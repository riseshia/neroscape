class RemoveReviewedFromReview < ActiveRecord::Migration
  def change
    remove_column :reviews, :reviewed, :integer
  end
end
