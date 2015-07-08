module Business

  class BookingsController < ApplicationController
    before_action :find_booking, only: [:edit, :update, :destroy]

    def index
      @service = Service.find(params[:service_id])
      @bookings= Booking.all
    end

    def show
      @service = Service.find(params[:service_id]
      @booking = current_user.bookings.find(params[:id])
    end

    def new
      @service = Service.find(params[:service_id])
      @booking = Booking.new
    end

    def create
       @service = Service.find(params[:service_id])
     @booking = current_user.institutes.services.bookings.new(params[:id])
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
       redirect_to business_institute_path(current_user)
     else
       render :new
     end
    end

    def edit
      @service = @booking.service
    end

    def update
      @service = Service.find(params[:service_id])
      @booking.update(booking_params)
      redirect_to bookings_user_path
    end

    def destroy
      @booking.destroy
      redirect_to business_institute_path(current_user)
    end

    private

    def find_booking
      @booking = current_user.institutes.services.bookings.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:user_id, :service_id, :start_datetime, :end_datetime)
    end
  end

end
