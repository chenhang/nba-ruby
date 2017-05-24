require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
require 'nokogiri'
require 'pry'
require 'net/https'
require 'mechanize'

SUB_CATEGORIES = %w(all defensive offensive passing detailed)

def api(sub_category = 'all')
  "https://www.whoscored.com/StatisticsFeed/1/GetPlayerStatistics?category=summary&subcategory=#{sub_category}&statsAccumulationType=0&isCurrent=true&playerId=&teamIds=32&matchId=&stageId=&tournamentOptions=2&sortBy=Rating&sortAscending=&age=&ageComparisonType=&appearances=&appearancesComparisonType=&field=Overall&nationality=&positionOptions=&timeOfTheGameEnd=&timeOfTheGameStart=&isMinApp=false&page=&includeZeroValues=true&numberOfPlayersToPick="
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"
  h1 = open("https://www.whoscored.com/Statistics")
  h2 = open(api, "Cookie" => h1.meta['set-cookie'].split('; ',2)[0],'User-Agent' => user_agent)
  # a = Mechanize.new { |agent|
  #   agent.user_agent_alias = 'Mac Safari'
  # }
  # page = a.get(api)

  # JSON.parse open(api, 'User-Agent' => user_agent).read
  binding.pry
end


# SUB_CATEGORIES.map do |sub_category|
#   data = get api(sub_category)
#   File.open("data/#{sub_category}.json", "w") do |f|
#     f.write(data.to_json)
#   end
# end
keys  = ["goal","assistTotal","shotsPerGame","aerialWonPerGame","manOfTheMatch","passSuccess","all_rating","tacklePerGame","interceptionPerGame","foulsPerGame","offsideWonPerGame","clearancePerGame","wasDribbledPerGame","outfielderBlockPerGame","defensive_rating","keyPassPerGame","dribbleWonPerGame","foulGivenPerGame","offsideGivenPerGame","dispossessedPerGame","turnoverPerGame","offensive_rating","totalPassesPerGame","accurateCrossesPerGame","accurateLongPassPerGame","accurateThroughBallPerGame","passing_rating","shotSixYardBox","shotPenaltyArea","shotOboxTotal","shotsTotal","detailed_rating"]
results = {}
SUB_CATEGORIES.map do |sub_category|
  data = JSON.parse(File.open("_data/#{sub_category}.json").read)
  players = data['playerTableStats']
  players.each do |player|
    player["#{sub_category}_rating"] = player['rating']
    title = "#{player['name']}, #{player['positionText']}"
    results[title] = {} if results[title].nil?
    keys.each do |key|
      results[title][key] = player[key] unless player[key].blank?
    end
  end
end
ranges = {}
keys.each do |key|
  all = results.values.map {|v| v[key].to_f }
  ranges[key] = all.sort
end


CSV.open("_data/mu.csv", "wb") do |csv|
  csv << ['type', 'name', 'value', 'actual_value']
  results.each do |name, result|
    result.each do |key, actual_value|
      actual_value = actual_value.to_f
      all = ranges[key]
      value = (all.count {|v| v <= actual_value} / all.size.to_f).abs * 100
      csv << [key, name, value.round(2), actual_value.round(2)]
    end
  end
end
binding.pry