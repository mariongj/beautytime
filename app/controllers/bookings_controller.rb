class BookingsController < ApplicationController

  def index
    @bookings = current_user.bookings
    @my_bookings = []
    @bookings.each do |booking|
      @my_bookings << booking.service
      end
  end

  def new
    @booking = Booking.new
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
  end

  def create
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
    @booking = @service.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to institute_service_bookings_path(@institute, @service, @booking)
    else
      render :new
    end
  end


  private


  def booking_params
    params.require(:booking).permit(:user_id, :service_id, :start_datetime, :end_datetime)
  end

end
