PLAYER
player_id display_last_comma_first rosterstatus from_year to_year playercode team_id
nba_player_id display_name roster_status from_year to_year player_code nba_team_id

rails g model player nba_player_id:integer display_name:string roster_status:integer from_year:string to_year:string player_code:string nba_team_id:integer


BASIC STAT
["player_id", "season_id", "team_id", "player_age", "gp", "gs", "min", "fgm", "fga", "fg_pct", "fg3_m", "fg3_a", "fg3_pct", "ftm", "fta", "ft_pct", "oreb", "dreb", "reb", "ast", "stl", "blk", "tov", "pf", "pts"]
["nba_player_id", "nba_season", "nba_team_id", "player_age", "gp", "gs", "min", "fgm", "fga", "fg_pct", "fg3_m", "fg3_a", "fg3_pct", "ftm", "fta", "ft_pct", "oreb", "dreb", "reb", "ast", "stl", "blk", "tov", "pf", "pts"]

rails g model BasicStat player:references nba_player_id:integer nba_season:string nba_team_id:integer player_age:integer gp:integer gs:integer min:integer fgm:integer fga:integer fg_pct:integer fg3_m:integer fg3_a:integer fg3_pct:integer ftm:integer fta:integer ft_pct:integer oreb:integer dreb:integer reb:integer ast:integer stl:integer blk:integer tov:integer pf:integer pts:integer


PASS_DASHBOARD
["fg2a", "fg_pct", "fg2m", "team_id", "frequency", "pass", "player_id", "team_name", "fg3a", "ast", "fg3m", "fgm", "fg3_pct", "fga", "g", "player_name_last_first", "fg2_pct", "pass_teammate_player_id", "pass_to", "pass_type"]
["fg2a", "fg_pct", "fg2m", "nba_team_id", "frequency", "pass", "player_id", "team_name", "fg3a", "ast", "fg3m", "fgm", "fg3_pct", "fga", "g", "player_name_last_first", "fg2_pct", "pass_teammate_player_id", "pass_to", "pass_type"]


player_shot_dashboard:
http://stats.nba.com/stats/playerdashptshots?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=


player_dashboard_advanced:
http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Advanced&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=


player_dashboard_misc:
http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Misc&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=


player_profile:
http://stats.nba.com/stats/playerprofilev2?GraphEndSeason=2013-14&GraphStartSeason=2013-14&GraphStat=PTS&LeagueID=00&MeasureType=Base&PerMode=PerGame&PlayerID=201566&SeasonType=Regular+Season&SeasonType=Playoffs


player_dashboard_usage:
http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Usage&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=


common_player_info:
http://stats.nba.com/stats/commonplayerinfo?LeagueID=00&PlayerID=201566&SeasonType=Regular+Season


pts_video_detail:
http://stats.nba.com/stats/videodetails?AheadBehind=&CFID=33&CFPARAMS=2014-15&ClutchTime=&ContextFilter=&ContextMeasure=PTS&DateFrom=&DateTo=&EndPeriod=10&EndRange=0&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&PointDiff=&Position=&RangeType=1&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=0&VsConference=&VsDivision=


player_rebound_dashboard:
http://stats.nba.com/stats/playerdashptreb?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=


shotlog:
http://stats.nba.com/stats/playerdashptshotlog?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&Period=0&PlayerID=201566&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=


stl_video_detail:
http://stats.nba.com/stats/videodetails?AheadBehind=&CFID=33&CFPARAMS=2014-15&ClutchTime=&ContextFilter=&ContextMeasure=STL&DateFrom=&DateTo=&EndPeriod=10&EndRange=0&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&PointDiff=&Position=&RangeType=1&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=0&VsConference=&VsDivision=


player_info:
http://stats.nba.com/stats/commonplayerinfo?GraphEndSeason=2013-14&GraphStartSeason=2013-14&GraphStat=PTS&LeagueID=00&MeasureType=Base&PerMode=PerGame&PlayerID=201566&SeasonType=Regular+Season&SeasonType=Playoffs


player_pass_dashboard:
http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=


player_gamelog:
http://stats.nba.com/stats/playergamelog?LeagueID=00&PlayerID=201566&Season=2014-15&SeasonType=Regular+Season


rebounds:
http://stats.nba.com/stats/playerdashptreboundlogs?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&Period=0&PlayerID=201566&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=


player_dashboard_scoring:
http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Scoring&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=


tov_video_detail:
http://stats.nba.com/stats/videodetails?AheadBehind=&CFID=33&CFPARAMS=2014-15&ClutchTime=&ContextFilter=&ContextMeasure=TOV&DateFrom=&DateTo=&EndPeriod=10&EndRange=0&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&PointDiff=&Position=&RangeType=1&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=0&VsConference=&VsDivision=


detail_shotlog:
http://peterbeshai.com/buckets/api/?player=201566&season=2014


ast_video_detail:
http://stats.nba.com/stats/videodetails?AheadBehind=&CFID=33&CFPARAMS=2014-15&ClutchTime=&ContextFilter=&ContextMeasure=AST&DateFrom=&DateTo=&EndPeriod=10&EndRange=0&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&PointDiff=&Position=&RangeType=1&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=0&VsConference=&VsDivision=


fga_video_detail:
http://stats.nba.com/stats/videodetails?AheadBehind=&CFID=33&CFPARAMS=2014-15&ClutchTime=&ContextFilter=&ContextMeasure=FGA&DateFrom=&DateTo=&EndPeriod=10&EndRange=0&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&PointDiff=&Position=&RangeType=1&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=0&VsConference=&VsDivision=


blk_video_detail:
http://stats.nba.com/stats/videodetails?AheadBehind=&CFID=33&CFPARAMS=2014-15&ClutchTime=&ContextFilter=&ContextMeasure=BLK&DateFrom=&DateTo=&EndPeriod=10&EndRange=0&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&PointDiff=&Position=&RangeType=1&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=0&VsConference=&VsDivision=


reb_video_detail:
http://stats.nba.com/stats/videodetails?AheadBehind=&CFID=33&CFPARAMS=2014-15&ClutchTime=&ContextFilter=&ContextMeasure=REB&DateFrom=&DateTo=&EndPeriod=10&EndRange=0&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&PointDiff=&Position=&RangeType=1&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=1&StartRange=0&TeamID=0&VsConference=&VsDivision=


player_defence_dashboard:
http://stats.nba.com/stats/playerdashptshotdefend?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=


shotchart_detail:
http://stats.nba.com/stats/shotchartdetail?CFID=33&CFPARAMS=2014-15&ContextFilter=&ContextMeasure=FGA&DateFrom=&DateTo=&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=201566&PlusMinus=N&Position=&Rank=N&RookieYear=&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=


player_dashboard_base:
http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=201566&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=


