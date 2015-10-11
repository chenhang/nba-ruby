class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :nba_player_id
      t.string :display_name
      t.integer :roster_status
      t.string :from_year
      t.string :to_year
      t.string :player_code
      t.integer :nba_team_id

      t.timestamps
    end
  end
end
