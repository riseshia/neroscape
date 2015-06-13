class CreateAppearances < ActiveRecord::Migration
  def change
    create_table :appearances do |t|
      t.integer :creator_id
      t.integer :game_id
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
