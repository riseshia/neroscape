class Join < ActiveRecord::Base
  attr_accessible :game_id, :user_id, :role, :role_detail, :role_detail_name

  belongs_to :game
  belongs_to :creater
end
