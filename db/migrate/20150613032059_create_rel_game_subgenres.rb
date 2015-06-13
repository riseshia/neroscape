class CreateRelGameSubgenres < ActiveRecord::Migration
  def change
    create_table :rel_game_subgenres do |t|
      t.integer :game_id
      t.integer :subgenre_id

      t.timestamps null: false
    end
  end
end
