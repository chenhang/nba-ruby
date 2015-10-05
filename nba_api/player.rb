class Player < NbaApi::BasicStats
  BASE_URL = 'http://stats.nba.com/stats'
  FIND_PATH = '/playerprofilev2'
  ALL_PATH = '/commonallplayers'

  def default_params

    {all: {IsOnlyCurrentSeason: 1, LeagueID: 00, Season: current_season},
     find: {GraphEndSeason: current_season, GraphStartSeason: current_season, GraphStat: 'PTS', LeagueID: 00,
            MeasureType: 'Base', PerMode: 'Totals', SeasonType: 'Regular+Season', PlayerID: 000000}}
  end

  def self.apis
    {find: BASE_URL+FIND_PATH, all: BASE_URL+ALL_PATH}
  end
end
