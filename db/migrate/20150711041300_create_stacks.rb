class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.references :game_id, index: true, foreign_key: true
      t.references :user_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
