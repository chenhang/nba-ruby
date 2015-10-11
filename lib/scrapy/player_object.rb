class PlayerObject < BasicStats
  BASE_URL = 'http://stats.nba.com/stats'
  FIND_PATH = '/playercareerstats'
  ALL_PATH = '/commonallplayers'

  def default_params

    {all: {IsOnlyCurrentSeason: 1, LeagueID: '00', Season: current_season},
     find: {LeagueID: '00', PerMode: 'Totals', PlayerID: id}}
  end

  def self.apis
    {find: BASE_URL+FIND_PATH, all: BASE_URL+ALL_PATH}
  end

  def player_params
    {"nba_player_id" => player_id, "display_name" => display_last_comma_first, "roster_status" => rosterstatus,
     "from_year" => from_year, "to_year" => to_year, "player_code" => playercode, "nba_team_id" => team_id}
  end

  def basic_stats_categories
    ["SeasonTotalsRegularSeason", "CareerTotalsRegularSeason", "SeasonTotalsPostSeason", "CareerTotalsPostSeason"]
  end

  def basic_stats_params
    season_id = try(:season_id) || 'career'
    {"nba_player_id" => player_id, "nba_season" => season_id,
     "nba_team_id" => team_id, "player_age" => player_age,
     "gp" => gp, "gs" => gs, "min" => min, "fgm" => fgm,
     "fga" => fga, "fg_pct" => fg_pct, "fg3_m" => fg3_m,
     "fg3_a" => fg3_a, "fg3_pct" => fg3_pct, "ftm" => ftm,
     "fta" => fta, "ft_pct" => ft_pct, "oreb" => oreb, "dreb" => dreb,
     "reb" => reb, "ast" => ast, "stl" => stl, "blk" => blk,
     "tov" => tov, "pf" => pf, "pts" => pts}
  end
end