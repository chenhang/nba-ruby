require 'json'
require 'csv'
require 'open-uri'
TEAMS = {:MIL => "1610612749", :GSW => "1610612744", :MIN => "1610612750", :MIA => "1610612748", :ATL => "1610612737", :BOS => "1610612738", :DET => "1610612765", :NYK => "1610612752", :DEN => "1610612743", :DAL => "1610612742", :BKN => "1610612751", :POR => "1610612757", :OKC => "1610612760", :TOR => "1610612761", :CHI => "1610612741", :SAS => "1610612759", :CHA => "1610612766", :UTA => "1610612762", :CLE => "1610612739", :HOU => "1610612745", :WAS => "1610612764", :LAL => "1610612747", :PHI => "1610612755", :MEM => "1610612763", :LAC => "1610612746", :SAC => "1610612758", :ORL => "1610612753", :PHX => "1610612756", :IND => "1610612754", :NOP => "1610612740"}

def player_list_api
  "http://stats.nba.com/stats/commonallplayers?IsOnlyCurrentSeason=0&LeagueID=00&Season=2015-16"
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse
  result = {}
  json_data = get player_list_api
  json_data['resultSets'].each do |data_set|
    headers = data_set['headers']
    data_set['rowSet'].each do |data|
      result[data[0].to_s] = data[1]
    end
  end
  File.open("data/player_list.json", "w") do |f|
    f.write(result.to_json)
  end
end


parse