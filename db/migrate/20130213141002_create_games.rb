class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :session_token
      t.string :x_token
      t.string :o_token
      t.string :last_played_owner
      t.integer :last_column
      t.integer :last_row
      t.timestamps
    end
  end
end
