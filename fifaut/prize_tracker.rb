require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'nokogiri'
require 'pry-rails'

def get_json(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  open(api, 'User-Agent' => user_agent).read
end

def save(data)
  File.open("result/result.json", "w") do |f|
    f.write(data.to_json)
  end
end

def api(name)
  "https://www.futbin.com/search?year=17&term=#{name}"
end

def search(name, position = nil, rating = nil)
  original_data = get_json(api(name))
  original_data.select do |player|
    filters = []
    filters << (player['rating'] == rating.to_s) if rating.present?
    filters << (player['position'].downcase == position.to_s) if position.present?
    filters.all?
  end
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
  end.compact.to_h.merge rating: html_object.css('.pcdisplay-rat').text.gsub(',', '').gsub(' ', '').gsub("\n", ''),
                 position: html_object.css('.pcdisplay-pos').text.gsub(',', '').gsub(' ', '').gsub("\n", ''),
                 prize: html_object.css('//*[@id="pslbin"]').children.first.text.gsub(',', '').gsub(' ', '')
  data.update basic_info

  futbin_player_id = html_object.css('#linkedto').attribute('data-resourceid').value
  prize_change_json = get_json("https://www.futbin.com/pages/player/graph.php?type=daily_graph&year=17&player=#{futbin_player_id}")['ps'].last(3).map(&:last)
  data['yesterday changes'] = "#{((prize_change_json[1] / prize_change_json[0].to_f - 1) * 100).to_i}%" rescue "-"
  data['today changes'] = "#{((prize_change_json[2] / prize_change_json[1].to_f - 1) * 100).to_i}%" rescue "-"

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

run
prize_run