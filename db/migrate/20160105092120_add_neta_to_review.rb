class AddNetaToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :neta, :integer, default: 1
  end
end
