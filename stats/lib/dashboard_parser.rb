require 'json'
require 'csv'
require 'open-uri'
require 'active_support/all'
TEAMS = {:MIL => "1610612749", :GSW => "1610612744", :MIN => "1610612750", :MIA => "1610612748", :ATL => "1610612737", :BOS => "1610612738", :DET => "1610612765", :NYK => "1610612752", :DEN => "1610612743", :DAL => "1610612742", :BKN => "1610612751", :POR => "1610612757", :OKC => "1610612760", :TOR => "1610612761", :CHI => "1610612741", :SAS => "1610612759", :CHA => "1610612766", :UTA => "1610612762", :CLE => "1610612739", :HOU => "1610612745", :WAS => "1610612764", :LAL => "1610612747", :PHI => "1610612755", :MEM => "1610612763", :LAC => "1610612746", :SAC => "1610612758", :ORL => "1610612753", :PHX => "1610612756", :IND => "1610612754", :NOP => "1610612740"}

PER_MODE = {'GeneralStats' => ['Totals', 'PerGame', 'Per36', 'Per100Plays', 'Per100Possessions'],
            'TrackingStats' => ['Totals', 'PerGame']}
MEASURE_TYPES = ['Base', 'Advanced', 'Misc', 'Scoring', 'Usage', 'Defense']
TRACKING_MEASURE_TYPES = ['SpeedDistance', 'Rebounding', 'Possessions', 'CatchShoot', 'PullUpShot', 'Defense', 'Drives', 'Passing', 'ElbowTouch', 'PostTouch', 'PaintTouch', 'Efficiency']
PARAMS = {'GeneralStats' => MEASURE_TYPES, 'TrackingStats' => TRACKING_MEASURE_TYPES}

def dashboard_api(team_id, opp_team_id, type, per_mode, season)
  "http://stats.nba.com/stats/leaguedashplayerstats?College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear=&GameScope=&GameSegment=&Height=&LastNGames=0&LeagueID=00&Location=&MeasureType=#{type}&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&PORound=0&PaceAdjust=N&PerMode=#{per_mode}&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=#{season}&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StarterBench=&TeamID=#{team_id}&VsConference=&VsDivision=&Weight="
end

def tracking_dashboard_api(team_id, opp_team_id, type, per_mode, season)
  "http://stats.nba.com/stats/leaguedashptstats?College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear=&GameScope=&Height=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&PORound=0&PerMode=#{per_mode}&PlayerExperience=&PlayerOrTeam=Player&PlayerPosition=&PtMeasureType=#{type}&Season=#{season}&SeasonSegment=&SeasonType=Regular+Season&StarterBench=&TeamID=#{team_id}&VsConference=&VsDivision=&Weight="
end

def api(category, team_id, opp_team_id, type, per_mode, season)
  {'GeneralStats' => dashboard_api(team_id, opp_team_id, type, per_mode, season),
   'TrackingStats' => tracking_dashboard_api(team_id, opp_team_id, type, per_mode, season)}[category]
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse(season, team_id = 0, opp_team_id = 0)
  result = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = [] } }
  PARAMS.each do |category, types|
    types.each do |type|
      PER_MODE[category].each do |per_mode|
        puts category, type, per_mode
        json_data = get api(category, team_id, opp_team_id, type, per_mode, season)
        json_data['resultSets'].each do |data_set|
          headers = data_set['headers']
          data_set['rowSet'].each do |data|
            stats = {}

            headers.each_with_index do |header, i|
              stats[header] = data[i]
            end
            result[category+per_mode][type].push stats
          end
        end
      end
    end
  end
  PER_MODE['TrackingStats'].each do |per_mode|
    result['TrackingStats' + per_mode]['Efficiency'].each do |temp|
      pts = temp['POINTS']
      keys = temp.keys
      keys.each do |k|
        if k.include?('_PTS')
          freq = pts == 0 ? 0 : temp[k]/pts
          temp[k.gsub('_PTS', '_FREQUENCY')] = freq
        end
      end
    end
  end
  result
end

def download_for season
  file_name = "#{season}_general_dashboard"
  File.open("result/dashboard/#{season}/#{file_name}.json", "w") do |f|
    f.write(parse(season).to_json)
  end
end

send(*ARGV)