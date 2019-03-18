class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :turn, default: "O"
      t.string :winner
      t.text :board, array: true, default: [
        [ "-", "-", "-" ],
        [ "-", "-", "-" ],
        [ "-", "-", "-" ]
      ]
      t.integer :turn_count, default: -1
      t.text :winning_coordinates, array: true
      t.integer :wins_x
      t.integer :wins_y
      t.integer :draws

      t.timestamps
    end
  end
end
