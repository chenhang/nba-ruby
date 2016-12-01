require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'

TEAMS = {:MIL => "1610612749", :GSW => "1610612744", :MIN => "1610612750", :MIA => "1610612748", :ATL => "1610612737", :BOS => "1610612738", :DET => "1610612765", :NYK => "1610612752", :DEN => "1610612743", :DAL => "1610612742", :BKN => "1610612751", :POR => "1610612757", :OKC => "1610612760", :TOR => "1610612761", :CHI => "1610612741", :SAS => "1610612759", :CHA => "1610612766", :UTA => "1610612762", :CLE => "1610612739", :HOU => "1610612745", :WAS => "1610612764", :LAL => "1610612747", :PHI => "1610612755", :MEM => "1610612763", :LAC => "1610612746", :SAC => "1610612758", :ORL => "1610612753", :PHX => "1610612756", :IND => "1610612754", :NOP => "1610612740"}

CATEGORIES = {'Overall' => "overall", 'GeneralShooting' => "general", 'ShotClockShooting' => "shot_clock", 'DribbleShooting' => "dribble", 'ClosestDefenderShooting' => "closest_defender", 'ClosestDefender10ftPlusShooting' => "closest_defender_10ft", 'TouchTimeShooting' => "touch_time"}

PARAMS = {"GeneralRange" => ["GeneralRange", ["Totals", "Catch+and+Shoot", "Pullups", "Less+then+10+ft"]],
          "ShotClockRange" => ["ShotClockRange", ["24-22", "22-18+Very+Early", "18-15+Early", "15-7+Average", "7-4+Late", "4-0+Very+Late", "ShotClock+Off", "Not+Captured"]],
          "DribbleRange" => ["DribbleRange", ["0+Dribbles", "1+Dribble", "2+Dribbles", "3-6+Dribbles", "7%2B+Dribbles"]],
          "ClosestDefenderRange" => ["CloseDefDistRange", ["0-2+Feet+-+Very+Tight", "2-4+Feet+-+Tight", "4-6+Feet+-+Open", "6%2B+Feet+-+Wide+Open"]],
          "ClosestDefender10ftPlusRange" => ["CloseDefDistRange", ["0-2+Feet+-+Very+Tight", "2-4+Feet+-+Tight", "4-6+Feet+-+Open", "6%2B+Feet+-+Wide+Open"]],
          "TouchTimeRange" => ["TouchTimeRange", ["Touch+%3C+2+Seconds", "Touch+2-6+Seconds", "Touch+6%2B+Seconds"]]}

EXTRA_PARAMS = {'ClosestDefender10ftPlusRange' => '&ShotDistRange=%3E%3D10.0'}

def player_shot_dashboard_api(team_id=0, opp_team_id=0, player_id=0)
  "http://stats.nba.com/stats/playerdashptshots?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&PerMode=PerGame&Period=0&PlayerID=#{player_id}&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&TeamID=#{team_id}&VsConference=&VsDivision="
end

def team_shot_dashbord_api(team_id=0, opp_team_id=0, player_id=0)
  "http://stats.nba.com/stats/teamdashptshots?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlusMinus=N&Rank=N&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&TeamID=#{team_id}&VsConference=&VsDivision="
end

def league_shot_dashboard_api(key, index, season)
  param = "&#{PARAMS[key][0]}=#{PARAMS[key][1][index]}"
  "http://stats.nba.com/stats/leaguedashplayerptshot?College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear=&GameScope=&GameSegment=&Height=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=#{season}&SeasonSegment=&SeasonType=Regular+Season&StarterBench=&TeamID=0&VsConference=&VsDivision=&Weight=#{param}#{EXTRA_PARAMS[key]}"
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse(team_id=0, opp_team_id=0, player_id=0)
  result = Hash.new { |h, k| h[k] = [] }
  json_data = get(team_shot_dashbord_api(team_id, opp_team_id, player_id))
  json_data['resultSets'].each do |data_set|
    headers = data_set['headers']
    name = CATEGORIES[data_set['name']]
    data_set['rowSet'].each do |data|
      shots = {}

      headers.each_with_index do |header, i|
        shots[header] = data[i]
      end
      result[name].push shots
    end
  end
  result
end

def parse_league season
  result = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = [] } }
  PARAMS.each do |k, v|
    v[1].each_with_index do |_, i|
      json_data = get league_shot_dashboard_api(k, i, season)
      filter = json_data['parameters'][v[0]]
      json_data['resultSets'].each do |data_set|
        headers = data_set['headers']
        data_set['rowSet'].each do |data|
          shots = {}

          headers.each_with_index do |header, i|
            shots[header] = data[i]
          end
          result[k][filter].push shots
        end
      end
    end
  end
  result
end

def download_for season
  file_name = "#{season}_shot_dashbard"
  File.open("result/dashboard/#{season}/#{file_name}.json", "w") do |f|
    f.write(parse_league(season).to_json)
  end
end

send(*ARGV)