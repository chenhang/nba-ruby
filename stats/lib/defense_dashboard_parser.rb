require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'

TEAMS = {:MIL => "1610612749", :GSW => "1610612744", :MIN => "1610612750", :MIA => "1610612748", :ATL => "1610612737", :BOS => "1610612738", :DET => "1610612765", :NYK => "1610612752", :DEN => "1610612743", :DAL => "1610612742", :BKN => "1610612751", :POR => "1610612757", :OKC => "1610612760", :TOR => "1610612761", :CHI => "1610612741", :SAS => "1610612759", :CHA => "1610612766", :UTA => "1610612762", :CLE => "1610612739", :HOU => "1610612745", :WAS => "1610612764", :LAL => "1610612747", :PHI => "1610612755", :MEM => "1610612763", :LAC => "1610612746", :SAC => "1610612758", :ORL => "1610612753", :PHX => "1610612756", :IND => "1610612754", :NOP => "1610612740"}

CATEGORIES = ['Overall', '3+Pointers', '2+Pointers', 'Less+Than+6Ft', 'Less+Than+10Ft', 'Greater+Than+15Ft']

def league_defense_dashboard_api(category, season)
  "http://stats.nba.com/stats/leaguedashptdefend?College=&Conference=&Country=&DateFrom=&DateTo=&DefenseCategory=#{category}&Division=&DraftPick=&DraftYear=&GameSegment=&Height=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PerMode=PerGame&Period=0&PlayerExperience=&PlayerPosition=&Season=#{season}&SeasonSegment=&SeasonType=Regular+Season&StarterBench=&TeamID=0&VsConference=&VsDivision=&Weight="
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse_league(season)
  result = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = [] } }
  CATEGORIES.each do |category|
    json_data = get league_defense_dashboard_api(category, season)
    filter = json_data['parameters']['DefenseCategory']
    json_data['resultSets'].each do |data_set|
      headers = data_set['headers']
      data_set['rowSet'].each do |data|
        defenses = {}

        headers.each_with_index do |header, i|
          defenses[header] = data[i]
        end
        defenses['PLAYER_ID'] = defenses['CLOSE_DEF_PERSON_ID']
        result['DefenseDashboard'][filter].push defenses
      end
    end
  end
  result
end

def download_for season
  file_name = "#{season}_defense_dashboard"
  File.open("result/dashboard/#{season}/#{file_name}.json", "w") do |f|
    f.write(parse_league(season).to_json)
  end
end

send(*ARGV)