class AddPlayerToBasicStats < ActiveRecord::Migration
  def change
    add_reference :basic_stats, :player, index: true, foreign_key: true
  end
end
