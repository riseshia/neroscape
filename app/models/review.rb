class Review < ActiveRecord::Base
  attr_accessible :user_id, :game_id, :story, :cg, :voice, :system, :hscene, :music, :total, :has_link, :link, :comments

  belongs_to :user
  belongs_to :game

  validates :total, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
end
