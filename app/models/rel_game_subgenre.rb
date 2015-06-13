class RelGameSubgenre < ActiveRecord::Base
  belongs_to :game
  belongs_to :subgenre
end
