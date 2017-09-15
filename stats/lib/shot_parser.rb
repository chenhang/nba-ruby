require 'json'
require 'csv'
require 'open-uri'
TEAMS = {:MIL => "1610612749", :GSW => "1610612744", :MIN => "1610612750", :MIA => "1610612748", :ATL => "1610612737", :BOS => "1610612738", :DET => "1610612765", :NYK => "1610612752", :DEN => "1610612743", :DAL => "1610612742", :BKN => "1610612751", :POR => "1610612757", :OKC => "1610612760", :TOR => "1610612761", :CHI => "1610612741", :SAS => "1610612759", :CHA => "1610612766", :UTA => "1610612762", :CLE => "1610612739", :HOU => "1610612745", :WAS => "1610612764", :LAL => "1610612747", :PHI => "1610612755", :MEM => "1610612763", :LAC => "1610612746", :SAC => "1610612758", :ORL => "1610612753", :PHX => "1610612756", :IND => "1610612754", :NOP => "1610612740"}


def detail_shot_api(team_id, opp_team_id, player_id)
  "http://stats.nba.com/stats/shotchartdetail?CFID=&CFPARAMS=&ContextFilter=&ContextMeasure=FGA&DateFrom=&DateTo=&EndPeriod=10&EndRange=28800&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=#{opp_team_id}&Outcome=&Period=0&PlayerID=#{player_id}&Position=&RangeType=2&RookieYear=&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=#{team_id}&VsConference=&VsDivision=&mtitle=&mtype=&PlayerPosition"
end

def get(api)
  puts api
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse(team_id = 0, opp_team_id = 0, player_id = 0)
  result = []
  json_data = get(detail_shot_api(team_id, opp_team_id, player_id))
  headers = json_data['resultSets'].first['headers']

  json_data['resultSets'].first['rowSet'].each do |data|
    shot = {}

    headers.each_with_index do |header, i|
      shot[header] = data[i]
    end

    result.push shot
  end
  result
end

def split_shots_by_game_result(file_name)
  json_data = JSON.parse(File.read("result/team_shots/#{file_name}_shots.json"))
  winners = JSON.parse(File.read('result/winners.json'))
  win_shots = []
  lose_shots = []
  json_data.each do |shot|
    if winners[shot['GAME_ID']] == shot['TEAM_ID']
      win_shots.push shot
    else
      lose_shots.push shot
    end
  end
  File.open("result/team_shots/#{file_name}_win_shots.json", "w") do |f|
    f.write(win_shots.to_json)
  end
  File.open("result/team_shots/#{file_name}_lose_shots.json", "w") do |f|
    f.write(lose_shots.to_json)
  end
end

def parse_league()
  TEAMS.each do |team, id|
    shots = parse(id)
    shots_name = team.to_s.downcase
    vs_shots = parse(0, id)
    vs_shots_name = 'vs_' + shots_name
    File.open("result/team_shots/#{shots_name}_shots.json", "w") do |f|
      f.write(shots.to_json)
    end

    File.open("result/team_shots/#{vs_shots_name}_shots.json", "w") do |f|
      f.write(vs_shots.to_json)
    end

    # split_shots_by_game_result(shots_name)
    # split_shots_by_game_result(vs_shots_name)
  end
end

parse_league