class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
			t.string :token
			t.integer :player_1_id
			t.integer :player_2_id
      t.timestamps
    end
  end
end
