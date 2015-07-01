class InstitutesController < ApplicationController
  before_action :find_institute, only: [ :show, :edit, :update, :destroy ]

  def index
    if params[:city] && params[:category]
      @institutes = Institute.where(city: params[:city]).where(category: params[:capacity])
    else
      @institutes = Institute.all
    end
  end


  def show
    @services = @institute.services
  end

  def new
    @institute = Institute.new
  end

  def create
    @institute = current_user.institutes.build(institute_params)
    @institute.validated = 0
    if @institute.save
      redirect_to institute_path(@institute)
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
    redirect_to institutes_path
  end

  private

  def find_institute
    @institute = Institute.find(params[:id])
  end

  def institute_params
    params.require(:institute).permit( :user_id, :name, :description, :address, :city, :zipcode, :picture1, :picture2, :picture3)
  end
end
