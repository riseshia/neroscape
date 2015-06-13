class Character < ActiveRecord::Base
  belongs_to :creator
  belongs_to :game
end
