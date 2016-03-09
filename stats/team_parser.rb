require 'json'
require 'csv'
require 'open-uri'
TEAMS = {:MIL => "1610612749", :GSW => "1610612744", :MIN => "1610612750", :MIA => "1610612748", :ATL => "1610612737", :BOS => "1610612738", :DET => "1610612765", :NYK => "1610612752", :DEN => "1610612743", :DAL => "1610612742", :BKN => "1610612751", :POR => "1610612757", :OKC => "1610612760", :TOR => "1610612761", :CHI => "1610612741", :SAS => "1610612759", :CHA => "1610612766", :UTA => "1610612762", :CLE => "1610612739", :HOU => "1610612745", :WAS => "1610612764", :LAL => "1610612747", :PHI => "1610612755", :MEM => "1610612763", :LAC => "1610612746", :SAC => "1610612758", :ORL => "1610612753", :PHX => "1610612756", :IND => "1610612754", :NOP => "1610612740"}

TEAMS_BY_ID = {'1610612749' => :MIL, '1610612744' => :GSW, '1610612750' => :MIN, "1610612748" => :MIA, "1610612737" => :ATL, "1610612738" => :BOS, "1610612765" => :DET, "1610612752" => :NYK, "1610612743" => :DEN, "1610612742" => :DAL, "1610612751" => :BKN, "1610612757" => :POR, "1610612760" => :OKC, "1610612761" => :TOR, "1610612741" => :CHI, "1610612759" => :SAS, "1610612766" => :CHA, "1610612762" => :UTA, "1610612739" => :CLE, "1610612745" => :HOU, "1610612764" => :WAS, "1610612747" => :LAL, "1610612755" => :PHI, "1610612763" => :MEM, "1610612746" => :LAC, "1610612758" => :SAC, "1610612753" => :ORL, "1610612756" => :PHX, "1610612754" => :IND, "1610612740" => :NOP}

TYPES = {base: 'Base', advanced: 'Advanced', factors: 'Four+Factors',
         misc: 'Misc', scoring: 'Scoring', opp: 'Opponent'}

PER_MODE = {total: 'Totals', per_game: 'PerGame',
            per_poss: 'Per100Possessions', per_plays: 'Per100Plays'}

def team_dashboard_api(team_id=0, opp_team_id=0, type=TYPES[:base], per_mode=PER_MODE[:total])
  "http://stats.nba.com/stats/leaguedashteamstats?Conference=&DateFrom=&DateTo=&Division=&GameScope=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=#{type}&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&PORound=0&PaceAdjust=N&PerMode=#{per_mode}&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StarterBench=&TeamID=#{team_id}&VsConference=&VsDivision="
end

def get(api)
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse(team_id, opp_team_id)
  result = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = {} } }
  TYPES.values.each do |type|
    json_data = get(team_dashboard_api(team_id, opp_team_id, type))
    json_data['resultSets'].each do |data_set|
      headers = data_set['headers']
      data_set['rowSet'].each do |data|
        team = {}
        headers.each_with_index do |header, i|
          team[header] = data[i]
        end

        name = TEAMS_BY_ID[team['TEAM_ID'].to_s]

        result[name].update team
      end
    end
  end
  result
end

puts parse(0, 0).to_json
