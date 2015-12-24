# Character
class Character < ActiveRecord::Base
  belongs_to :creator
  belongs_to :game

  delegate :title => :game, prefix: true
  delegate :name => :creator, prefix: true
end
