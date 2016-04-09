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

  delegate :name, to: :brand, prefix: true

  scope :next_releases, lambda {
    where('release_date >= ?', Time.zone.today.strftime('%Y/%m/%d')).order('release_date ASC')
  }

  scope :released, lambda {
    where('release_date <= ?', Time.zone.today.strftime('%Y/%m/%d')).order('release_date DESC')
  }
 # if params[:brand_id]
 #   Game.includes(:brand).where('brand_id = ?', params[:brand_id])
 # else
 #   Game.includes(:brand)
 # end

  scope :by_release_date, -> { order(release_date: :desc) }
  scope :with_brand, lambda { |value|
    where('brand_id = ?', value)
  }
  scope :with_year, -> (year) { where('release_date like ?', "#{year}%") }
  scope :with_month, -> (month) { where('release_date like ?', "%-#{month}-%") }

  def self.with_filter(filters)
    last_self = self
    last_self = last_self.with_brand(filters[:brand_id]) if filters[:brand_id]
    last_self = last_self.with_year(filters[:year]) if filters[:year]
    last_self = last_self.with_month(filters[:month]) if filters[:month]
    last_self
  end


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
