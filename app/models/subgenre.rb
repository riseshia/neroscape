# Subgenre
class Subgenre < ActiveRecord::Base
  has_many :rel_game_subgenre
  has_many :games, through: :rel_game_subgenre
end
