class Appearance < ActiveRecord::Base
  belongs_to :creator, :game, :role
end
