class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
			t.integer :player_1_id
			t.integer :player_2_id
      t.string :token
      t.boolean :game_state
      t.integer :turn
      t.string :board_plays
      t.string :winner
      t.timestamps
    end
  end
end
