class InstitutesController < ApplicationController
  before_action :find_institute, only: [:show]



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
          marker.lat institute.latitude
          marker.lng institute.longitude
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




  private

  def find_institute
    @institute = Institute.find(params[:id])
  end

  def institute_params
    params.require(:institute).permit( :user_id, :name, :description, :address, :city, :zipcode, :picture1, :picture2, :picture3, :date, :time)
  end

end
