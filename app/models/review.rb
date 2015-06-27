class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :score, presence: true
  validates :content, presence: true
  validates :reviewed, presence: true

  def editable? user
    puts user_id
    return true if user.id == user_id
    return true if user.admin?
    false
  end
end
