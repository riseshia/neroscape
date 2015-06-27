class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews

  def unlocked?
    self.level != 0
  end

  def admin?
    self.level == 999
  end

  def reviewed? game
    Review.find_by(user_id: self.id, game_id: game.id).present?
  end
end
