class Creater < ActiveRecord::Base
  attr_accessible :name, :furigana
  
  has_many :join
end
