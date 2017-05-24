require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'nokogiri'
require 'pry-rails'

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  open(api, 'User-Agent' => user_agent).read
end

def api(year, round)
  "http://www.worldfootball.net/schedule/eng-premier-league-#{year}-#{year + 1}-spieltag/#{round}/"
end

def season(year)
  "#{year}-#{year + 1}"
end

def get_tables(year)
  (1..38).map do |round|
    html = get(api(year, round))
    html_object = Nokogiri::HTML(html)
    columns = html_object.css('#site > div.white > div.content > div > div:nth-child(7) > div > table.standard_tabelle > tr')
    heads = columns.first.children.css('th').map { |f| f.text }
    columns.map do |t|
      Hash[heads.zip t.children.css('td').map { |f| f.text.gsub("\t", '').gsub("\r\n", '').presence }.compact]
    end.last(20)
  end
end

def run
  result = {}
  (1995..2015).each do |year|
    result[year] = get_tables(year)
  end
  File.open("result.json", "w") do |f|
    f.write(result.to_json)
  end
end

def analysis(rank: 6, compare_type: 'only_contain')
  data = JSON.parse(File.open('results.json').read)
  size = data.size
  (0..36).map do |round|
    percent = data.values.map do |teams|
      final = teams.last.first(rank).map { |t| t['Team'] }
      current = teams[round].first(rank).map { |t| t['Team'] }
      case compare_type
        when 'only_contain'
          (final & current).size.to_f / rank
        when 'same'
          (0..rank-1).map do |i|
            current[i] == final[i] ? 1 : 0
          end.sum.to_f / rank
        when 'moved'
          (current - final).size.to_f / rank
        when 'get_in'
          current_mtd = teams[round][5]['Team']
          (current_mtd & final).size.to_f / rank
        else
          (final & current).size.to_f / rank
      end
    end.sum.to_f / size
    [round+1, percent.round(2)]
  end.to_h
end

def analysis_rank_by_end(rank: 6, round: 17)
  data = JSON.parse(File.open('results.json').read)
  data.map do |year, year_data|
    team = year_data[round - 1][rank - 1]
    final = year_data.last.find {|d| d['Team'] == team['Team']}
    d = {team: team['Team'], year: year, final_rank: final['#'],
         current_pts: team['Pt.'], final_pts: final['Pt.'],
         current_highest_pts: year_data[round - 1].first['Pt.'], final_highest_pts: year_data.last.first['Pt.']}
    p d
  end.sort_by { |d| d[:final_rank].to_i }
end

def clean
  data = JSON.parse(File.open('result.json').read)
  results = {}
  data.map do |key, year|
    results[key] = year.map do |round|
      rank = '1'
      round.map do |team|
        keys = team.keys
        values = team.values.compact
        if keys.size != values.size
          values = [rank] + values
        end
        rank = values.first
        keys.zip(values).to_h
      end
    end
  end
  File.open("results.json", "w") do |f|
    f.write(results.to_json)
  end
end

# p analysis(rank: 4, compare_type: 'get_in')
puts analysis_rank_by_end.to_json