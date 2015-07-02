class BookingsController < ApplicationController

  def index

  end

  def new
    @booking = Booking.new
    @institute = Institute.find(params[:institute_id])
    @service = Service.find(params[:service_id])
  end

  def create

  end

end
