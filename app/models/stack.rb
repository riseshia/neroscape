# Stack
class Stack < ActiveRecord::Base
  include Editable

  belongs_to :game
  belongs_to :user

  delegate :title, to: :game, prefix: true

  validates :game_id, presence: true
  validates :user_id, presence: true
end
