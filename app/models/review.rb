# Review
class Review < ActiveRecord::Base
  include Editable

  belongs_to :user
  belongs_to :game

  delegate :title, to: :game, prefix: true
  delegate :name, to: :user, prefix: true

  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :score, presence: true, numericality: {
    only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
  validates :content, presence: true
  validate :content_cannot_be_empty

  def stacked?
    reviewed == 0
  end

  def reviewed?
    !stacked?
  end

  def content_cannot_be_empty
    # because of summernote
    errors.add(:content, "can't be empty") if content == '<br>'
  end
end
