class ReviewsController < ApplicationController

  def new
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(booking_id: @booking.id)
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.reviews.build(review_params)
    if @review.save
      redirect_to institute_path(booking.service.institute)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:reviews).permit(:rate, :comments)
  end
end
