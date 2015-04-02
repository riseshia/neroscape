module ApplicationHelper
  def score(num)
    if num == -1
      "X"
    else
      num
    end
  end

  def total_avg(review)
    count = 0
    sum = 0
    if review.story != -1
      sum += review.story
      count += 1
    end
    if review.cg != -1
      sum += review.cg
      count += 1
    end
    if review.voice != -1
      sum += review.voice
      count += 1
    end
    if review.music != -1
      sum += review.music
      count += 1
    end
    if review.system != -1
      sum += review.system
      count += 1
    end
    if review.hscene != -1
      sum += review.hscene
      count += 1
    end
    
    sum = sum.to_f/count
    sum.round(1)
  end

  def score_str(review)
    "#{score(review.story)}/#{score(review.cg)}/#{score(review.voice)}/#{score(review.music)}/#{score(review.system)}/#{score(review.hscene)}"
  end
end
