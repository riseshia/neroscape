# Editable module
module Editable
  def editable?(user)
    return true if user.id == user_id
    return true if user.admin?
    false
  end
end