# Stack
class Stack < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  delegate :title, to: :game, prefix: true

  validates :game_id, presence: true
  validates :user_id, presence: true

  def editable?(user)
    return true if user.id == user_id
    return true if user.admin?
    false
  end
end
