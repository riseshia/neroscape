class Stack < ActiveRecord::Base
  belongs_to :game_id
  belongs_to :user_id
end
