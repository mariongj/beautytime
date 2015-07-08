module Business

  class Business::ServicesController < ApplicationController
  before_action :find_service, only: [ :show, :edit, :update, :destroy ]
  before_action :find_timetable, only: [ :show, :edit, :update, :destroy ]

  def show
    @start_time = [@timetable[0].monday_start_time, @timetable[0].monday_end_time, @timetable[0].tuesday_start_time, @timetable[0].tuesday_end_time, @timetable[0].wednesday_start_time, @timetable[0].wednesday_end_time, @timetable[0].thursday_start_time, @timetable[0].thursday_end_time, @timetable[0].friday_start_time, @timetable[0].friday_end_time, @timetable[0].saturday_start_time, @timetable[0].saturday_end_time, @timetable[0].sunday_start_time, @timetable[0].sunday_end_time].min
    @end_time = [@timetable[0].monday_start_time, @timetable[0].monday_end_time, @timetable[0].tuesday_start_time, @timetable[0].tuesday_end_time, @timetable[0].wednesday_start_time, @timetable[0].wednesday_end_time, @timetable[0].thursday_start_time, @timetable[0].thursday_end_time, @timetable[0].friday_start_time, @timetable[0].friday_end_time, @timetable[0].saturday_start_time, @timetable[0].saturday_end_time, @timetable[0].sunday_start_time, @timetable[0].sunday_end_time].max

    @search_date = params[:search_date] ? params[:search_date].to_date : Date.today

    @institute = Institute.find(params[:institute_id])
    @date = params[:date]
    @time = params[:time]

    @booking = Booking.new
  end

  def new
    @institute = Institute.find(params[:institute_id])
    @service = Service.new
  end

  def create
    @institute = Institute.find(params[:institute_id])
    @service = @institute.services.new(service_params)
    if @service.save
      redirect_to new_business_service_timetable_path(@service)
    else
      render :new
    end
  end

  def edit
    @institute = Institute.find(params[:institute_id])
  end

  def update
    @institute = Institute.find(params[:institute_id])
    @service.update(service_params)
    redirect_to business_institute_path(@institute)
  end

  def destroy
    @service.destroy
    @institute = Institute.find(params[:institute_id])
    redirect_to business_institute_path(@institute)
  end

  private

  def find_service
    @service = Service.find(params[:id])
  end

  def find_timetable
    @timetable = @service.timetables[0]
  end

  def service_params
    params.require(:service).permit(:institute_id, :title, :description, :price, :duration, :category)
  end

  end
end
