class TimetablesController < ApplicationController
  before_action :find_service, only: [:new, :create]

  def new
    @timetable = Timetable.new
  end

  def create
    @timetable = Timetable.new(timetable_params)
    @timetable.service = @service
    if @timetable.save
      redirect_to institute_service_path(@service.institute, @service)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def find_service
    @service = Service.find(params[:service_id])
  end

  def timetable_params
    params.require(:timetable).permit(:service_id, :monday_start_time, :monday_end_time, :tuesday_start_time, :tuesday_end_time, :wednesday_start_time, :wednesday_end_time, :thursday_start_time, :thursday_end_time, :friday_start_time, :friday_end_time, :saturday_start_time, :saturday_end_time, :sunday_start_time, :sunday_end_time)
  end
end
