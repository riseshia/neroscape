class Subgenre < ActiveRecord::Base
  has_many :games, through: :rel_game_subgenre
end