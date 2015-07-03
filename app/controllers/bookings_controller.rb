class BookingsController < ApplicationController

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


  private


  def booking_params
    params.require(:booking).permit(:user_id, :service_id, :start_datetime, :end_datetime)
  end

end
