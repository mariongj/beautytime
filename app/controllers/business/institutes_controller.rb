module Business

  class Business::InstitutesController < ApplicationController
    before_action :find_institute, only: [ :show, :edit, :update, :destroy ]

    def index
      @institutes = current_user.institutes
      @markers = Gmaps4rails.build_markers(@institutes) do |institute, marker|
            marker.lat institute.latitude
            marker.lng institute.longitude
      end
    end

    def show
      @reviews = @institute.reviews
      @services = @institute.services
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
          redirect_to new_business_institute_service_path(@institute)
        else
          render :new
        end
      end

      def edit
        @institute
      end

      def update
        @institute.update(institute_params)
        redirect_to business_institute_path
      end

      def destroy
        @institute.destroy
        redirect_to :back
      end

      private

      def find_institute
        @institute = current_user.institutes.find(params[:id])
      end

      def institute_params
        params.require(:institute).permit( :user_id, :name, :description, :address, :city, :zipcode, :picture1, :picture2, :picture3, :date, :time)
      end

  end

end
