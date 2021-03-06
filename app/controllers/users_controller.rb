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
    @past_bookings = current_user.bookings.where("start_datetime < ?", DateTime.now).order(start_datetime: :desc)
    @pending_bookings = current_user.bookings.where("start_datetime >= ?", DateTime.now).order(start_datetime: :desc)
  end

  def institutes
    @bookings = current_user.bookings
    @my_institutes_uniques = @bookings.map { |booking| booking.service.institute }.uniq
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def set_user
    params.require(:user).permit(:first_name, :last_name, :is_woman, :phone_number, :birthdate, :address, :zipcode, :city, :picture)
  end



end
