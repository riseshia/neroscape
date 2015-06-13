class Character < ActiveRecord::Base
  belongs_to :creator, :game
end
