class ServicesController < ApplicationController
  before_action :find_service, only: [ :show, :edit, :update, :destroy ]

  def show
    @start_time = "10:00".to_time
    @end_time = "19:00".to_time
  end

  def new
    @institute = Institute.find(params[:institute_id])
    @service = Service.new
  end

  def create
    @institute = Institute.find(params[:institute_id])
    @service = @institute.services.new(service_params)
    if @service.save
      redirect_to institute_path(@institute)
    else
      render :new
    end
  end

  def edit
    @service
  end

  def update
    @service.update(service_params)
    redirect_to service_path(@service)
  end

  def destroy
    @service.destroy
    redirect_to services_path
  end

  private

  def find_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit( :institute_id, :title, :description, :price, :duration, :category)
  end

end
