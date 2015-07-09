module ApplicationHelper

  def average_stars(institute)
    if institute.reviews.size == 0
      return 0
    else
      stocked_reviews =[]
      institute.reviews.each do |review|
        stocked_reviews << review.rate
      end
      return stocked_reviews.inject(:+) / institute.reviews.size
    end
  end


end

