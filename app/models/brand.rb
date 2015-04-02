class Brand < ActiveRecord::Base
  attr_accessible :name, :furigana

  has_many :game

  validates :furigana, presence: true
  validates :name, presence: true
  validates :id, uniqueness: {scope: :id}, presence: true
end
