class InstitutesController < ApplicationController
  def index
    @institutes = Institute.all
  end

  def show
    @institute = Institute.find(params[:id])
  end

  def new
    @institute = Institute.new
  end

  def create
    @institute = current_user.institutes.build(institute_params)
    if @institute.save
      redirect_to institute_path(@institute)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def institute_params
    params.require(:institute).permit( :user_id, :name, :description, :address, :city, :zipcode, :picture1, :picture2, :picture3)
  end
end
