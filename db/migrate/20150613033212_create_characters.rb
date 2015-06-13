class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :image_url
      t.integer :game_id
      t.integer :creator_id
      t.text :description

      t.timestamps null: false
    end
  end
end
