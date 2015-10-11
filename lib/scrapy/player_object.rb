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
    {"nba_player_id"=>player_id, "display_name"=>display_last_comma_first, "roster_status"=>rosterstatus,
     "from_year"=>from_year, "to_year"=>to_year, "player_code"=>playercode, "nba_team_id"=>team_id}
  end
end