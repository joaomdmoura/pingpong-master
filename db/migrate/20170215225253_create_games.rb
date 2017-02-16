class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player, references: :users, index: true
      t.references :opponent, references: :users, index: true
      t.date :played_at
      t.integer :player_score
      t.integer :opponent_score

      t.timestamps null: false
    end
  end
end
