module Business

  class BookingsController < ApplicationController
    before_action :find_booking, only: [:show, :edit, :update, :destroy]

    def index
      @service = Service.find(params[:service_id])
      @bookings= Booking.all
    end

    def show
      @service = Service.find(params[:service_id])
    end

    def new
      @service = Service.find(params[:service_id])
      @timetable = Timetable.where({ service_id: params[:service_id] })
      @start_time = [@timetable[0].monday_start_time, @timetable[0].monday_end_time, @timetable[0].tuesday_start_time, @timetable[0].tuesday_end_time, @timetable[0].wednesday_start_time, @timetable[0].wednesday_end_time, @timetable[0].thursday_start_time, @timetable[0].thursday_end_time, @timetable[0].friday_start_time, @timetable[0].friday_end_time, @timetable[0].saturday_start_time, @timetable[0].saturday_end_time, @timetable[0].sunday_start_time, @timetable[0].sunday_end_time].min
      @end_time = [@timetable[0].monday_start_time, @timetable[0].monday_end_time, @timetable[0].tuesday_start_time, @timetable[0].tuesday_end_time, @timetable[0].wednesday_start_time, @timetable[0].wednesday_end_time, @timetable[0].thursday_start_time, @timetable[0].thursday_end_time, @timetable[0].friday_start_time, @timetable[0].friday_end_time, @timetable[0].saturday_start_time, @timetable[0].saturday_end_time, @timetable[0].sunday_start_time, @timetable[0].sunday_end_time].max
      @search_date = params[:search_date] ? params[:search_date].to_date : Date.today

      @institute = @service.institute
      @booking = Booking.new
    end

    def create
      @service = current_user.services.find(params[:service_id])
      @booking = @service.bookings.build(booking_params)


      # @date = params[:booking][:date]
      # @time = params[:booking][:time]
      # year = @date.split("-")[0].to_i
      # month = @date.split("-")[1].to_i
      # day = @date.split("-")[2].to_i
      # hour = @time.split(":")[0].to_i
      # min = @time.split(":")[1].to_i

      # @booking.start_datetime = DateTime.new(year, month, day, hour, min, 0)
      @booking.end_datetime = @booking.start_datetime + @service.duration.minutes

      if @booking.save
       redirect_to business_institute_path(@service.institute)
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
      params.require(:booking).permit(:start_datetime)
    end

  end


end
