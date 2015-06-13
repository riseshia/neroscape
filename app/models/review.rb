class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def editable? user
    puts user_id
    return true if user.id == user_id
    return true if user.admin?
    false
  end
end
