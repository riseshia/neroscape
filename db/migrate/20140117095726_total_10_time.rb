class Total10Time < ActiveRecord::Migration
  def up
    Review.all.each do |review|
      review.total *= 10
      review.save!
    end
  end

  def down
    Review.all.each do |review|
      review.total /= 10
      review.save!
    end
  end
end
