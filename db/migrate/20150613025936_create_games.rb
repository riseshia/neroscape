class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :poster_url
      t.integer :price
      t.string :genre
      t.text :story
      t.integer :brand_id
      t.integer :getchu_id
      t.date :release_date

      t.timestamps null: false
    end
  end
end
