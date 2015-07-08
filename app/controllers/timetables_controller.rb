class TimetablesController < ApplicationController
  before_action :find_service, only: [:new, :create]

  def new
    @timetable = Timetable.new
  end

  def create

    @timetable = Timetable.new

    @timetable.monday_start_time = Time.new(2000,01,01,params[:timetable][:monday_start_time].split(":")[0].to_i+1,params[:timetable][:monday_start_time].split(":")[1].to_i,0)
    @timetable.tuesday_start_time = Time.new(2000,01,01,params[:timetable][:tuesday_start_time].split(":")[0].to_i+1,params[:timetable][:tuesday_start_time].split(":")[1].to_i,0)
    @timetable.wednesday_start_time = Time.new(2000,01,01,params[:timetable][:wednesday_start_time].split(":")[0].to_i+1,params[:timetable][:wednesday_start_time].split(":")[1].to_i,0)
    @timetable.thursday_start_time = Time.new(2000,01,01,params[:timetable][:thursday_start_time].split(":")[0].to_i+1,params[:timetable][:thursday_start_time].split(":")[1].to_i,0)
    @timetable.friday_start_time = Time.new(2000,01,01,params[:timetable][:friday_start_time].split(":")[0].to_i+1,params[:timetable][:friday_start_time].split(":")[1].to_i,0)
    @timetable.saturday_start_time = Time.new(2000,01,01,params[:timetable][:saturday_start_time].split(":")[0].to_i+1,params[:timetable][:saturday_start_time].split(":")[1].to_i,0)
    @timetable.sunday_start_time = Time.new(2000,01,01,params[:timetable][:sunday_start_time].split(":")[0].to_i+1,params[:timetable][:sunday_start_time].split(":")[1].to_i,0)

    @timetable.monday_end_time = Time.new(2000,01,01,params[:timetable][:monday_end_time].split(":")[0].to_i+1,params[:timetable][:monday_end_time].split(":")[1].to_i,0)
    @timetable.tuesday_end_time = Time.new(2000,01,01,params[:timetable][:tuesday_end_time].split(":")[0].to_i+1,params[:timetable][:tuesday_end_time].split(":")[1].to_i,0)
    @timetable.wednesday_end_time = Time.new(2000,01,01,params[:timetable][:wednesday_end_time].split(":")[0].to_i+1,params[:timetable][:wednesday_end_time].split(":")[1].to_i,0)
    @timetable.thursday_end_time = Time.new(2000,01,01,params[:timetable][:thursday_end_time].split(":")[0].to_i+1,params[:timetable][:thursday_end_time].split(":")[1].to_i,0)
    @timetable.friday_end_time = Time.new(2000,01,01,params[:timetable][:friday_end_time].split(":")[0].to_i+1,params[:timetable][:friday_end_time].split(":")[1].to_i,0)
    @timetable.saturday_end_time = Time.new(2000,01,01,params[:timetable][:saturday_end_time].split(":")[0].to_i+1,params[:timetable][:saturday_end_time].split(":")[1].to_i,0)
    @timetable.sunday_end_time = Time.new(2000,01,01,params[:timetable][:sunday_end_time].split(":")[0].to_i+1,params[:timetable][:sunday_end_time].split(":")[1].to_i,0)

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

    @timetable.update(timetable_params)
    redirect_to business_institute_path(@institute)
  end

  private

  def find_service
    @service = Service.find(params[:service_id])
  end

  def timetable_params
    params.require(:timetable).permit(:service_id, :monday_start_time, :monday_end_time, :tuesday_start_time, :tuesday_end_time, :wednesday_start_time, :wednesday_end_time, :thursday_start_time, :thursday_end_time, :friday_start_time, :friday_end_time, :saturday_start_time, :saturday_end_time, :sunday_start_time, :sunday_end_time)
  end
end
