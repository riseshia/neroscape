class CreateRelGameCategories < ActiveRecord::Migration
  def change
    create_table :rel_game_categories do |t|
      t.integer :game_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
