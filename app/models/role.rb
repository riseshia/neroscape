# Role
class Role < ActiveRecord::Base
  has_many :appearances
  has_many :creators, through: :appearances
end
