require 'scrapy/scrapy'
namespace :get do
  desc 'get players'
  task players: :environment do
    ActiveRecord::Base.transaction do
      player_object = PlayerObject.new
      players = player_object.all.send('CommonAllPlayers'.underscore)
      players.each do |player|
        player_record = Player.find_or_create_by(nba_player_id: player.player_id)
        player_record.update!(player.player_params)
      end
    end
  end

  desc 'get players basic stats'
  task player_basic_stats: :environment do
    ActiveRecord::Base.transaction do
      Player.find_each do |player|
        player_object = PlayerObject.new(id: player.nba_player_id.to_s)
        player_stats = player_object.find
        player_stats.basic_stats_categories.each do |category|
          season_stats = player_stats.send(category.underscore)
          season_stats.each { |season_stat| BasicStat.find_or_create_by(season_stat.basic_stats_params).update(player_id: player.id) }
        end
      end
    end
  end
end