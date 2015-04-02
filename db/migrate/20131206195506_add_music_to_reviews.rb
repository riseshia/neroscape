class AddMusicToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :music, :integer
  end
end
