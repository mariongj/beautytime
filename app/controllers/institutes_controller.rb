class InstitutesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_institute, only: [ :show, :edit, :update, :destroy ]

  def index
    @institutes = Institute.all

    latitude = params[:lat]
    longitude = params[:lng]

    if latitude && longitude
      @institutes = @institutes.near([latitude, longitude], 5, units: :km)
    elsif params[:city].present?
      @institutes = @institutes.where(city: params[:city])
    end

    if params[:category].present?
      @institutes = @institutes.joins(:services).where(services: { category: params[:category] })
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
    redirect_to business_institute_path(@institute)
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
