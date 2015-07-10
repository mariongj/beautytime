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

  def title
    content_for?(:title) ? content_for(:title) : DEFAULT_META['title']
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META['meta_description']
  end

  def meta_image
    content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META['meta_image']
  end

end

