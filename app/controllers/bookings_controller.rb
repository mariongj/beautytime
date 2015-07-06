class BookingsController < ApplicationController
  before_action :find_booking, only: [:edit, :update, :destroy]

  def index
    @bookings = current_user.bookings
    @my_bookings = []
    @bookings.each do |booking|
      @my_bookings << booking.service
      end
  end

  def new
  end

  def create
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
    @booking = current_user.bookings.new
    @booking.service = @service
    @date = params[:booking][:date]
    @time = params[:booking][:time]
    year = @date.split("-")[0].to_i
    month = @date.split("-")[1].to_i
    day = @date.split("-")[2].to_i
    hour = @time.split(":")[0].to_i
    min = @time.split(":")[1].to_i
    @booking.start_datetime = DateTime.new(year, month, day, hour, min, 0)
    @booking.end_datetime = @booking.start_datetime + @service.duration
    if @booking.save
      redirect_to institute_path(@institute)
    else
      render :new
    end
  end

  def edit
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
    @booking = Booking.find(params(booking_params))
  end

  def update
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
    @booking = Booking.find(params(booking_params))
    @booking.update(booking_params)
    redirect_to bookings_user_path
  end

  def destroy
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
    @booking = Booking.find(params(booking_params))
    @booking.destroy
    redirect_to :back
  end


  private


  def booking_params
    params.require(:booking).permit(:user_id, :service_id, :start_datetime, :end_datetime)
  end

  def find_booking
    @booking = Booking.find(params[:booking_id])
  end

end
