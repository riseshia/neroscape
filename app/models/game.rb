class Game < ActiveRecord::Base
  belongs_to :brand

  has_many :reviews
  has_many :appearances
  has_many :creators, through: :appearances
  has_many :characters
  has_many :subgenres, through: :rel_game_subgenres
  has_many :rel_game_subgenres
  has_many :categories, through: :rel_game_categories
  has_many :rel_game_categories
end
