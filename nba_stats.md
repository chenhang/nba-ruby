PLAYER
player_id display_last_comma_first rosterstatus from_year to_year playercode team_id
nba_player_id display_name roster_status from_year to_year player_code nba_team_id

rails g model player nba_player_id:integer display_name:string roster_status:integer from_year:string to_year:string player_code:string nba_team_id:integer


BASIC STAT
["player_id", "season_id", "team_id", "player_age", "gp", "gs", "min", "fgm", "fga", "fg_pct", "fg3_m", "fg3_a", "fg3_pct", "ftm", "fta", "ft_pct", "oreb", "dreb", "reb", "ast", "stl", "blk", "tov", "pf", "pts"]
["nba_player_id", "nba_season", "nba_team_id", "player_age", "gp", "gs", "min", "fgm", "fga", "fg_pct", "fg3_m", "fg3_a", "fg3_pct", "ftm", "fta", "ft_pct", "oreb", "dreb", "reb", "ast", "stl", "blk", "tov", "pf", "pts"]

rails g model BasicStat nba_player_id:integer nba_season:string nba_team_id:integer player_age:integer gp:integer gs:integer min:integer fgm:integer fga:integer fg_pct:integer fg3_m:integer fg3_a:integer fg3_pct:integer ftm:integer fta:integer ft_pct:integer oreb:integer dreb:integer reb:integer ast:integer stl:integer blk:integer tov:integer pf:integer pts:integer


PASS_DASHBOARD
["fg2a", "fg_pct", "fg2m", "team_id", "frequency", "pass", "player_id", "team_name", "fg3a", "ast", "fg3m", "fgm", "fg3_pct", "fga", "g", "player_name_last_first", "fg2_pct", "pass_teammate_player_id", "pass_to", "pass_type"]
["fg2a", "fg_pct", "fg2m", "nba_team_id", "frequency", "pass", "player_id", "team_name", "fg3a", "ast", "fg3m", "fgm", "fg3_pct", "fga", "g", "player_name_last_first", "fg2_pct", "pass_teammate_player_id", "pass_to", "pass_type"]