class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]

    def index
          @places = Place.all.paginate(page: params[:page], per_page: 3)
          @search = params["search"]
              if @search.present?

                @description= @search["name"]
                @name = @search["name"]
                # desc_places = Place.where("description ILIKE ?", "%#{@description}%")
                # name_places = Place.where("name ILIKE ?", "%#{@name}%")
                # @places = (desc_places + name_places).paginate(page: params[:page], per_page: 3)
                @places = Place.where("name ILIKE ?", "%#{@name}%").or(Place.where("description ILIKE ?", "%#{@description}%")).paginate(page: params[:page], per_page: 3)
              end

          return @places
    end

    def new
        @place = Place.new
    end

    def create
        @place = current_user.places.create(place_params)
        if @place.valid?
          redirect_to root_path
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show
        @place = Place.find(params[:id])
        @comment = Comment.new
        @photo = Photo.new
    end

    def edit
        @place = Place.find(params[:id])

        if @place.user != current_user
          return render plain: 'Not Allowed', status: :forbidden
        end
    end

    def update
      @place = Place.find(params[:id])

        if @place.user != current_user
          return render plain: 'Not Allowed', status: :forbidden
        end

      @place.update_attributes(place_params)
      
        if @place.valid?
          redirect_to place_path
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
      @place = Place.find(params[:id])

        if @place.user != current_user
          return render plain: 'Not Allowed', status: :forbidden
        end
      @place.destroy
      redirect_to root_path
    end


      private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end
