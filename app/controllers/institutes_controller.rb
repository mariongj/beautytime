class InstitutesController < ApplicationController
  before_action :find_institute, only: [ :show, :edit, :update, :destroy ]



#     if params[:city] && params[:category]
#       @institutes = Institute.where(city: params[:city]).where(category: params[:capacity])
#         @markers = Gmaps4rails.build_markers(@institutes) do |institute, marker|
#         marker.lat institute.latitude
#         marker.lng institute.longitude
#         end

#     else
#       @institutes = Institute.all
#         @markers = Gmaps4rails.build_markers(@institutes) do |institute, marker|
#         marker.lat institute.latitude
#         marker.lng institute.longitude
#         end
# =======

  def index
      @institutes = Institute.all

      if params[:city]
        @institutes = @institutes.where(city: params[:city])
      end

      if params[:category]
        @institutes = @institutes.joins(:services).where(services: { category: params[:category] })
      end

      @markers = Gmaps4rails.build_markers(@institutes) do |institute, marker|
        if institute.latitude && institute.longitude
          marker.lat institute.latitude
          marker.lng institute.longitude
        else
          raise
        end

      end
  end

  def show
    @reviews = @institute.reviews
    @services = @institute.services
    @markers = Gmaps4rails.build_markers(@institute) do |institute, marker|
      marker.lat institute.latitude
      marker.lng institute.longitude
    end
    # @bookings = @institute.services.bookings
  end

  def new
    @institute = Institute.new
  end

  def create
    @institute = current_user.institutes.build(institute_params)
    @institute.validated = 0
    if @institute.save
      redirect_to new_institute_service_path(@institute)
    else
      render :new
    end
  end

  def edit
    @institute
  end

  def update
    @institute.update(institute_params)
    redirect_to institute_path(@institute)
  end

  def destroy
    @institute.destroy
    redirect_to :back
  end

  def businesses
    @institutes = current_user.institutes
  end

  def business
    @institute = Institute.find(params[:id])
    @services = @institute.services
    @markers = Gmaps4rails.build_markers(@institute) do |institute, marker|
      marker.lat institute.latitude
      marker.lng institute.longitude
    end
  end

  private

  def find_institute
    @institute = Institute.find(params[:id])
  end

  def institute_params
    params.require(:institute).permit( :user_id, :name, :description, :address, :city, :zipcode, :picture1, :picture2, :picture3, :date, :time)
  end

end
