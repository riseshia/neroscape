class Review < ActiveRecord::Base
  attr_accessible :user_id, :game_id, :story, :cg, :voice, :system, :hscene, :music, :total, :has_link, :link, :comments

  belongs_to :user
  belongs_to :game

  before_save :cal_total

  SCORE_TYPES = [ -1,0,1,2,3,4,5,6,7,8,9,10 ]

  validates :story, :numericality => { :only_integer => true, :greater_than_or_equal_to => -1, :less_than_or_equal_to => 10 }
  validates :cg, :numericality => { :only_integer => true, :greater_than_or_equal_to => -1, :less_than_or_equal_to => 10 }
  validates :voice, :numericality => { :only_integer => true, :greater_than_or_equal_to => -1, :less_than_or_equal_to => 10 }
  validates :hscene, :numericality => { :only_integer => true, :greater_than_or_equal_to => -1, :less_than_or_equal_to => 10 }
  validates :music, :numericality => { :only_integer => true, :greater_than_or_equal_to => -1, :less_than_or_equal_to => 10 }
  validates :system, :numericality => { :only_integer => true, :greater_than_or_equal_to => -1, :less_than_or_equal_to => 10 }

  def cal_total
    self.total = 0
    if self.story != -1
      self.total += self.story
    end
    if self.cg != -1
      self.total += self.cg
    end
    if self.voice != -1
      self.total += self.voice
    end
    if self.music != -1
      self.total += self.music
    end
    if self.system != -1
      self.total += self.system
    end
    if self.hscene != -1
      self.total += self.hscene
    end
  end
end
