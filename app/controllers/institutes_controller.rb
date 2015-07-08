class InstitutesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_institute, only: [:show]

  def index
    @institutes = Institute.all

    if params[:category].present?
      @institutes = @institutes.joins(:services).where(services: { category: params[:category] }).uniq
    end

    latitude = params[:lat]
    longitude = params[:lng]

    if latitude && longitude
      @institutes = @institutes.near([latitude, longitude], 5, units: :km)
    elsif params[:city].present?
      @institutes = @institutes.where(city: params[:city])
    end


    @markers = Gmaps4rails.build_markers(@institutes) do |institute, marker|
      if institute.latitude && institute.longitude
        marker.lat institute.latitude
        marker.lng institute.longitude
      end
    end
  end

  def show
    @reviews = @institute.reviews
    @services = @institute.services
    @reviews_average = reviews_average(@reviews)

    @markers = Gmaps4rails.build_markers(@institute) do |institute, marker|
      marker.lat institute.latitude
      marker.lng institute.longitude
    end
  end




  private

  def reviews_average(reviews)
    if reviews.size == 0
      return 0
    else
      reviews_stocked = []
      reviews.each do |review|
        reviews_stocked << review.rate
      end
      return reviews_stocked.inject(:+) / reviews.size
    end
  end

  def find_institute
    @institute = Institute.find(params[:id])
  end

  def institute_params
    params.require(:institute).permit( :user_id, :name, :description, :address, :city, :zipcode, :picture1, :picture2, :picture3, :date, :time)
  end
end
