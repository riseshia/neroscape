class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :homepage_url
      t.integer :getchu_id

      t.timestamps null: false
    end
  end
end
