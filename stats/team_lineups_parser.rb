require 'json'
require 'open-uri'


def advance_api(num)
  if num > 1
    "http://stats.nba.com/stats/leaguedashlineups?Conference=&DateFrom=&DateTo=&Division=&GameID=&GameSegment=&GroupQuantity=#{num}&LastNGames=0&LeagueID=00&Location=&MeasureType=Advanced&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlusMinus=N&Rank=N&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&TeamID=0&VsConference=&VsDivision="
  else
    "http://stats.nba.com/stats/leaguedashplayerstats?College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear=&GameScope=&GameSegment=&Height=&LastNGames=0&LeagueID=00&Location=&MeasureType=Advanced&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=Totals&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StarterBench=&TeamID=0&VsConference=&VsDivision=&Weight="
  end
end

def get(api)
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  JSON.parse open(api, 'User-Agent' => user_agent).read
end

def parse(num)
  avg_min = num == 1
  json_data = get(advance_api(num))
  sum = Hash.new {|h, k| h[k] = []}
  headers = json_data['resultSets'].first['headers']
  data_headers = headers - %w(GROUP_SET GROUP_ID GROUP_NAME TEAM_ID TEAM_ABBREVIATION W L PLAYER_ID PLAYER_NAME CFPARAMS AGE CFID)
  bounds_headers = data_headers + %w(GP MIN)
  result = {headers: data_headers, data: (Hash.new {|h, k| h[k] = []}), bounds: {}}

  json_data['resultSets'].first['rowSet'].each do |data|
    player = {}
    init = true

    headers.each_with_index do |header, i|
      player[header] = data[i]
      player['NAME'] = data[i] if header.include?('NAME')
      if player['GP'] && player['MIN'] && !avg_min && init
        player['MIN'] = player['MIN'].to_f / player['GP'].to_f
        init = false
      end
      sum[header].push player[header] if bounds_headers.include?(header) && (data[5] >= 22 && num == 1)
    end

    result[:data][player['TEAM_ABBREVIATION']].push player
    sum.each do |header, nums|
      result[:bounds][header] = {min: nums.min, max: nums.max}
    end
  end
  result
end

result = []
(1..5).each do |num|
  result.push parse(num)
end

puts result.to_json