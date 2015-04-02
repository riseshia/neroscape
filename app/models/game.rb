class Game < ActiveRecord::Base
  attr_accessible :name, :furigana, :sellday, :brand_id

  has_many :review
  has_many :join
  has_many :tsumige

  belongs_to :brand

  validates :brand_id, presence: true
  validates :name, presence: true
  validates :furigana, presence: true
  validates :sellday, presence: true
  validates :id, uniqueness: {scope: :id}, presence: true

  before_save :default_model

  def default_model
    self.model ||= "PC"
  end
end