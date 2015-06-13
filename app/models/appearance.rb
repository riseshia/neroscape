class Appearance < ActiveRecord::Base
  belongs_to :creator
  belongs_to :game
  belongs_to :role
end
