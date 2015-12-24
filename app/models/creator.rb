# Creator
class Creator < ActiveRecord::Base
  has_many :games, through: :appearances
  has_many :appearances
  has_many :characters
end
