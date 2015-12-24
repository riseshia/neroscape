# Game
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

  delegate :name => :brand, prefix: true

  def gennga(roles)
    role = roles.find { |r| r.name == '原画' }
    creators.where('role_id = ?', role.id)
  end

  def sdgennga(roles)
    role = roles.find { |r| r.name == 'SD原画' }
    creators.where('role_id = ?', role.id)
  end

  def writer(roles)
    role = roles.find { |r| r.name == 'シナリオ' }
    creators.where('role_id = ?', role.id)
  end
end
