require 'scrapy/scrapy'
namespace :get do
  desc 'get players'
  task players: :environment do
    ActiveRecord::Base.transaction do
      player_object = PlayerObject.new
      players = player_object.all.send('CommonAllPlayers'.underscore)
      players.each do |player|
        unless Player.exists?(nba_player_id: player.player_id)
          Player.create!(player.player_params)
        end
      end
    end
  end
end