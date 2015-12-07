require 'net/http'
require 'json'

def grab(api)
  uri = URI.parse(api)
  http = Net::HTTP.new uri.host, uri.port
  request = Net::HTTP::Get.new uri.request_uri
  response = http.request request
  JSON.parse(response.body)
end

KEY_MAPS = {
    Passing: "Passing",
    Defense: "Defense",
    Possessions: "Possessions",
    CatchShoot: "CatchShoot",
    SpeedDistance: "SpeedDistance",
    Rebounding: "Rebounding",
    PullUpShot: "PullUpShot",
    Drives: "Drives",
    ElbowTouch: "ElbowTouch",
    PostTouch: "PostTouch",
    PaintTouch: "PaintTouch",
    Efficiency: "Efficiency"
}

result = KEY_MAPS.map do |_, type|
  url = "http://stats.nba.com/stats/leaguedashptstats?PtMeasureType=" + type + "&College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear=&GameScope=&Height=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PerMode=PerGame&PlayerExperience=&PlayerOrTeam=Player&PlayerPosition=&Season=2015-16&SeasonSegment=&SeasonType=Regular+Season&StarterBench=&TeamID=0&VsConference=&VsDivision=&Weight=";
  headers = grab(url)['resultSets'][0]['headers']
  headers.map do |header|
    [header, {name: header, tips: "", reverse: false}]
  end.to_h
end

File.open("output.json","w") do |f|
  f.write(result.to_json)
end