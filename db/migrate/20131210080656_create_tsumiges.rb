class CreateTsumiges < ActiveRecord::Migration
  def change
    create_table :tsumiges do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
