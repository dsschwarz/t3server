class AddAvailableToGames < ActiveRecord::Migration
  def change
    add_column :games, :available, :boolean
  end
end
