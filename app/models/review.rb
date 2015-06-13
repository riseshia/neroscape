class Review < ActiveRecord::Base
  belongs_to :user, :game
  has_one :user
  has_one :game
end
