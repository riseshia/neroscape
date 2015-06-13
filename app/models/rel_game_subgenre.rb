class RelGameSubgenre < ActiveRecord::Base
  belongs_to :game, :subgenre
end
