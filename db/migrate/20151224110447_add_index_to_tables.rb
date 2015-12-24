class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :appearances, :creator_id
    add_index :appearances, :game_id
    add_index :appearances, :role_id
    add_index :characters, :game_id
    add_index :characters, :creator_id
    add_index :games, :brand_id
    add_index :rel_game_categories, :game_id
    add_index :rel_game_categories, :category_id
    add_index :rel_game_subgenres, :game_id
    add_index :rel_game_subgenres, :subgenre_id
    add_index :reviews, :user_id
    add_index :reviews, :game_id
  end
end
