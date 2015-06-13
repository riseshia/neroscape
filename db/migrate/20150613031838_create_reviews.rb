class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :score
      t.text :content
      t.integer :user_id
      t.integer :game_id
      t.integer :reviewed, default: 0

      t.timestamps null: false
    end
  end
end
