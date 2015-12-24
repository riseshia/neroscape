# Category
class Category < ActiveRecord::Base
  has_many :rel_game_categories
  has_many :games, through: :rel_game_categories
end
