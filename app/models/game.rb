class Game < ActiveRecord::Base
  belongs_to :brand

  has_many :reviews
  has_many :appearances
  has_many :creators, through: :appearances
  has_many :characters
end
