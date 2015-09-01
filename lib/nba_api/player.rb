class Player < ActiveStats::Base
  base_url 'http://stats.nba.com/stats'

  before_request :generate_params

  get :find, '/playerprofilev2', default: {PlayerID: 000000}
  get :all, '/commonallplayers', default: {}


  def default_params
    {all: {IsOnlyCurrentSeason: 1, LeagueID: 00, Season: current_season},
     find: {GraphEndSeason: current_season, GraphStartSeason: current_season, GraphStat: 'PTS', LeagueID: 00,
            MeasureType: 'Base', PerMode: 'Totals', SeasonType: 'Regular+Season'}}
  end


  def generate_params name, request
    request.get_params.update default_params[name] rescue default_params[name]
  end

end