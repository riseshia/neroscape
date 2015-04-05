class UpdateTotalScore < ActiveRecord::Migration
  def up
    reviews = Review.all
    
    reviews.each do |review|
      count = 0
      total = 0
      
      if review.story != -1
        count += 1
        total += review.story
      end
      if review.cg != -1
        count += 1
        total += review.cg
      end
      if review.voice != -1
        count += 1
        total += review.voice
      end
      if review.music != -1
        count += 1
        total += review.music
      end
      if review.system != -1
        count += 1
        total += review.system
      end
      if review.hscene != -1
        count += 1
        total += review.hscene
      end

      review.total = (total*10/count).to_i
      review.save
    end
  end
end
