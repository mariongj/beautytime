module ApplicationHelper
  def average_stars(institute)

    stocked_reviews =[]
    institute.reviews.each do |review|
      stocked_reviews << review.rate
    end

    average = stocked_reviews.inject(:+) / institute.reviews.size
    return average
  end
end
