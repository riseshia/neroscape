class Category < ActiveRecord::Base
  has_many :games, through: :rel_game_categories
end
