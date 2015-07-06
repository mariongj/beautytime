class BookingsController < ApplicationController
  before_action :find_booking, only: [:edit, :update, :destroy]

  def index
    @my_bookings = current_user.bookings
    # @my_bookings = []
    # @bookings.each do |booking|
    #   @my_bookings << booking
    #   end
  end

  def new
  end

  def create
    # @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
    @booking = current_user.bookings.new(params[:id])
    @booking.service = @service
    @date = params[:booking][:date]
    @time = params[:booking][:time]
    year = @date.split("-")[0].to_i
    month = @date.split("-")[1].to_i
    day = @date.split("-")[2].to_i
    hour = @time.split(":")[0].to_i
    min = @time.split(":")[1].to_i
    @booking.start_datetime = DateTime.new(year, month, day, hour, min, 0)
    @booking.end_datetime = @booking.start_datetime + @service.duration.minute
    if @booking.save
      redirect_to bookings_user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @service = @booking.service
  end

  def update
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
    @booking = Booking.find(params(booking_params))
    @booking.update(booking_params)
    redirect_to bookings_user_path
  end

  def destroy
    @booking.destroy
    redirect_to bookings_user_path(current_user)
  end

  private


  def booking_params
    params.require(:booking).permit(:user_id, :service_id, :start_datetime, :end_datetime)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

end
