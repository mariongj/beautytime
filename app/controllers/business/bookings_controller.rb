module Business

  class BookingsController < ApplicationController
    before_action :find_booking, only: [:edit, :update, :destroy]

    def index
      @service = Service.find(params[:service_id])
      @bookings= Booking.all
    end

    def show
      @service = Service.find(params[:service_id]

    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def find_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:user_id, :service_id, :start_datetime, :end_datetime)
    end
  end

end
