# Character
class Character < ActiveRecord::Base
  belongs_to :creator
  belongs_to :game

  delegate :title, to: :game, prefix: true
  delegate :name, to: :creator, prefix: true
end
