class CreateBasicStats < ActiveRecord::Migration
  def change
    create_table :basic_stats do |t|
      t.integer :nba_player_id
      t.string :nba_season
      t.integer :nba_team_id
      t.integer :player_age
      t.integer :gp
      t.integer :gs
      t.integer :min
      t.integer :fgm
      t.integer :fga
      t.integer :fg_pct
      t.integer :fg3_m
      t.integer :fg3_a
      t.integer :fg3_pct
      t.integer :ftm
      t.integer :fta
      t.integer :ft_pct
      t.integer :oreb
      t.integer :dreb
      t.integer :reb
      t.integer :ast
      t.integer :stl
      t.integer :blk
      t.integer :tov
      t.integer :pf
      t.integer :pts

      t.timestamps
    end
  end
end
