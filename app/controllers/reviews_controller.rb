class ReviewsController < ApplicationController

  def index
    @reviews = current_user.reviews
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(booking_id: @booking.id)
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.reviews.build(review_params)
    @review.user = current_user
    @review.institute = @booking.service.institute
    if @review.save
      flash[:notice] = "Votre commentaire a bien été enregistré."
      redirect_to bookings_user_path(current_user)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rate, :comments)
  end
end



