# ApplicationHelper
module ApplicationHelper
  def neta(review)
    review.neta == 0 ? 'ネタX' : 'ネタO'
  end
end
