class CreateJoins < ActiveRecord::Migration
  def change
    create_table :joins do |t|
      t.integer :game_id
      t.integer :creater_id
      t.integer :role
      t.integer :role_detail
      t.string :role_detail_name

      t.timestamps
    end
  end
end
