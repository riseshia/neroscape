module ApplicationHelper
  def score(num)
    if num == -1
      "X"
    else
      num
    end
  end

  def total_avg(review)
    review.total
  end

  def score_str(review)
    "#{score(review.story)}/#{score(review.cg)}/#{score(review.voice)}/#{score(review.music)}/#{score(review.system)}/#{score(review.hscene)}"
  end
end
