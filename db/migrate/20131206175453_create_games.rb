class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :furigana
      t.string :sellday
      t.integer :brand_id

      t.timestamps
    end
  end
end
