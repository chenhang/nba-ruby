require 'json'
require 'csv'
require 'open-uri'
TEAMS = {:MIL=>"1610612749", :GSW=>"1610612744", :MIN=>"1610612750", :MIA=>"1610612748", :ATL=>"1610612737", :BOS=>"1610612738", :DET=>"1610612765", :NYK=>"1610612752", :DEN=>"1610612743", :DAL=>"1610612742", :BKN=>"1610612751", :POR=>"1610612757", :OKC=>"1610612760", :TOR=>"1610612761", :CHI=>"1610612741", :SAS=>"1610612759", :CHA=>"1610612766", :UTA=>"1610612762", :CLE=>"1610612739", :HOU=>"1610612745", :WAS=>"1610612764", :LAL=>"1610612747", :PHI=>"1610612755", :MEM=>"1610612763", :LAC=>"1610612746", :SAC=>"1610612758", :ORL=>"1610612753", :PHX=>"1610612756", :IND=>"1610612754", :NOP=>"1610612740"}

CATEGORIES = {'Overall' => "overall", 'GeneralShooting' => "general", 'ShotClockShooting' => "pass_clock", 'DribbleShooting' => "dribble", 'ClosestDefenderShooting' => "closest_defender", 'ClosestDefender10ftPlusShooting' => "closest_defender_10ft", 'TouchTimeShooting' => "touch_time"}


def player_pass_dashboard_api(team_id=0, opp_team_id=0, player_id=0)
  "http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&PerMode=PerGame&Period=0&PlayerID=#{player_id}&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&TeamID=#{team_id}&VsConference=&VsDivision="
end

def team_pass_dashbord_api(team_id=0, opp_team_id=0, player_id=0)
  "http://stats.nba.com/stats/teamdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlusMinus=N&Rank=N&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&TeamID=#{team_id}&VsConference=&VsDivision="
end

def get(api)
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse(team_id, opp_team_id, player_id)
  result = Hash.new {|h, k| h[k] = []}
  json_data = get(team_pass_dashbord_api(team_id, opp_team_id, player_id))
  json_data['resultSets'].each do |data_set|
    headers = data_set['headers']
    name = CATEGORIES[data_set['name']]
    data_set['rowSet'].each do |data|
      passs = {}

      headers.each_with_index do |header, i|
        passs[header] = data[i]
      end

      result[name].push passs
    end
  end
  result
end

puts parse(TEAMS[:SAS], 0, 0).to_json