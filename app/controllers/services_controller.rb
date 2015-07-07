class ServicesController < ApplicationController
  before_action :find_service, only: [ :show, :edit, :update, :destroy ]
  before_action :find_timetable, only: [ :show, :edit, :update, :destroy ]

  def show
    @start_time = "10:00".to_time
    @end_time = "19:00".to_time

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
      redirect_to new_service_timetable_path(@service)
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
    @institute = Institute.find(params[:institute_id])
  end

  def update
    @service.update(service_params)
    @institute = Institute.find(params[:institute_id])
    redirect_to business_institute_path(@institute)
  end

  def destroy
    @service.destroy
    redirect_to :back
  end

  private

  def find_service
    @service = Service.find(params[:id])
  end

  def find_timetable
    @timetable = Timetable.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:institute_id, :title, :description, :price, :duration, :category)
  end

  # def service__params
  #    params.require(:service).permit(:service_id, :institute_id, :title, :description, :price, :duration, :category, :date, :time)
  # end

end
