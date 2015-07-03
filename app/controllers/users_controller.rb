class UsersController < ApplicationController


  before_action :find_user, only: [:edit, :update, :show]
  before_action :authenticate_user!


  def show
  end


  def edit
  end

  def update
    @user.update(set_user)
    redirect_to user_path
  end

  def bookings
    @bookings = current_user.bookings
  end

  def institutes
    @bookings = current_user.bookings
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def set_user
    params.require(:user).permit(:first_name, :last_name, :is_woman, :phone_number, :birthdate, :address, :zipcode, :city, :picture_file_name)
  end



end
