require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'nokogiri'
require 'pry-rails'

def to_valid_json!(str)
  (0..11).reverse_each { |i| str.gsub!("#{i}:", "'#{i}':") }
  str.gsub!("'", '"')
end

def parsed_name(name)
  name.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
end

def get_json(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(URI.extract(URI.encode(api)).first, 'User-Agent' => user_agent).read
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  open(URI.extract(URI.encode(api)).first, 'User-Agent' => user_agent).read
end

def save(data)
  File.open("result/result.json", "w") do |f|
    f.write(data.to_json)
  end
end

def squad_api(id)
  "http://www.futhead.com/squad-building-challenges/squads/#{id}/"
end

def api(name)
  "https://www.futbin.com/search?year=17&term=#{name}"
end

def search(name, position = nil, rating = nil, totw = nil, rare = nil)
  original_data = get_json(api(name))
  original_data.select do |player|
    filters = []
    filters << (player['rating'] == rating.to_s) unless rating.nil?
    filters << (player['position'].downcase == position.to_s.downcase) unless position.nil?
    filters << ([totw, player['version'] != 'Normal'].uniq.size == 1) unless totw.nil?
    filters << ([rare, player['rare'] == '1'].uniq.size == 1) unless rare.nil?
    filters.all?
  end
end

def get_squad(id)
  html = get(squad_api(id))
  data = JSON.parse(html.match(/'\[\{.*\}\]'/)[0][1..-2]).reject { |d| d['player'].blank? }
  player_data = extract_futhead_data(data)
  squad_position = JSON.parse to_valid_json!(html.match(/\{.*\}/)[0])
  requirement = JSON.parse to_valid_json!(html.match(/\(\[\{.*\}\]\)/)[0][1..-2])
  [id, {'origial_data' => data, 'players' => player_data, 'squad_position' => squad_position, 'requirement' => requirement}]
end

def get_squads(url)
  page = 1
  results = {}
  while true
    html = get(url + "&page=#{page}")
    html_object = Nokogiri::HTML(html)
    result = html_object.css('.player-item a').map do |a|
      get_squad a.attributes['href'].text.split('/').last
    end.to_h
    break if result.blank?
    results.merge!(result)
    page += 1
  end
  results
end

def get_sbcs
  html = get("http://www.futhead.com/squad-building-challenges/")
  html_object = Nokogiri::HTML(html)
  html_object.css('.challenge-set').map do |d|
    url = "http://www.futhead.com#{d.attributes['href'].text}"
    name = d.children[1].text.gsub('  ', '').gsub("\n", ' ').strip
    desc = d.children[3].text
    rewards = d.children[5].children[2].text.gsub(':', '').gsub("\n", '').strip
    expire = d.children[5].children[7].try(:attribute, 'data-default').try(:text)
    {url: url, name: name, desc: desc, rewards: rewards, expire: expire}
  end
end

def extract_futhead_data(data)
  data.map do |player|
    name = parsed_name player['data']['full_name']
    position = player['data']['position']
    rating = player['data']['rating']
    totw = player['data']['revision_type'] != 'NIF'
    rare = player['data']['rare']
    player_detail = search(name, position, rating, totw, rare).first
    data_of(player_detail['id']).merge('totw' => totw, 'rare' => rare).merge player_detail
  end
rescue
  binding.pry
end

def run
  data = JSON.parse(File.read('result/result.json'))
  begin
    players = CSV.parse(File.read('current_players.csv')).to_a
    players.each do |name, position, rating|
      key = [name, position, rating].join(',')
      if data[key] && data[key]['api'].present?
        data[key] = {}
      end
      next unless data[key].blank?
      result = search name, position, rating
      if result.blank?
        puts key
        result = {}
      elsif result.size > 1
        result = result.find { |player| player['version'] == 'Normal' }
      else
        result = result.first.to_h
      end
      data[key] = result
    end
  ensure
    File.open("result/result.json", "w") do |f|
      f.write(data.to_json)
    end unless data.blank?
  end
end

def data_of(id)
  html = get("https://www.futbin.com/17/player/#{id}")
  html_object = Nokogiri::HTML(html)
  data = {'id' => id}

  basic_info = html_object.css('#info_content').css('table').css('tr').map do |col|
    [col.css('th').text.downcase, col.css('.table-row-text').text.gsub(' years old', '').gsub(',', '').gsub('  ', '').gsub("\n", '')]
  end.compact.to_h.merge 'rating' => html_object.css('.pcdisplay-rat').text.gsub(',', '').gsub(' ', '').gsub("\n", ''),
                         'position' => html_object.css('.pcdisplay-pos').text.gsub(',', '').gsub(' ', '').gsub("\n", ''),
                         'prize' => html_object.css('//*[@id="pslbin"]').children.first.text.gsub(',', '').gsub(' ', '')
  data.update basic_info

  # futbin_player_id = html_object.css('#linkedto').attribute('data-resourceid').value
  # prize_change_json = get_json("https://www.futbin.com/pages/player/graph.php?type=daily_graph&year=17&player=#{futbin_player_id}")['ps'].last(3).map(&:last)
  # data['yesterday changes'] = "#{((prize_change_json[1] / prize_change_json[0].to_f - 1) * 100).to_i}%" rescue "-"
  # data['today changes'] = "#{((prize_change_json[2] / prize_change_json[1].to_f - 1) * 100).to_i}%" rescue "-"

  data
end

def prize_run
  timestamp = "#{Date.today.to_s}"
  t = Time.now.to_f
  prize_file = "result/prizes_by_date/prizes_#{timestamp}"
  `touch #{prize_file}.json`
  `touch #{prize_file}.csv`
  data = JSON.parse(File.read('result/result.json'))
  prizes = JSON.parse(File.read(prize_file + '.json')) rescue {}
  total_count = data.size
  current_count = prizes.size
  begin
    data.each do |key, player|
      next unless prizes[key].blank?
      puts "#{current_count}/#{total_count}"
      t1 = Time.now.to_f
      id = player['id']
      next if id.blank?
      prizes[key] = data_of(id)
      current_count += 1
      puts "Cost #{(Time.now.to_f - t1)}s"
    end
  ensure
    unless prizes.blank?
      File.open(prize_file + '.json', "w") do |f|
        f.write(prizes.to_json)
      end
      CSV.open(prize_file + '.csv', "wb") do |csv|
        csv << prizes.first.last.keys
        prizes.values.each { |hash| csv << hash.values }
      end
    end
    puts "Total Cost #{(Time.now.to_f - t)}s"
  end
end

def squads_run
  t = Time.now.to_f
  squads_file = "result/squads/squads"
  `touch #{squads_file}.json`
  results = JSON.parse(File.read(squads_file + '.json')) rescue {}
  begin
    results = get_squads('http://www.futhead.com/squad-building-challenges/493/hit-the-links/squads/?sort=new')
    binding.pry
  ensure
    unless results.blank?
      File.open(squads_file + '.json', "w") do |f|
        f.write(results.to_json)
      end
    end
    puts "Total Cost #{(Time.now.to_f - t)}s"
  end
end

# run
# prize_run
# get_squad(212275)
# get_squads('http://www.futhead.com/squad-building-challenges/493/hit-the-links/squads/?sort=new')
# squads_run
get_sbcs