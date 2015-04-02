class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :story
      t.integer :cg
      t.integer :voice
      t.integer :system
      t.integer :hscene
      t.integer :total
      t.integer :has_link
      t.string :link
      t.string :comments

      t.timestamps
    end
  end
end
