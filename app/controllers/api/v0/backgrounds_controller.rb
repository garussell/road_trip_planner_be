class Api::V0::BackgroundsController < ApplicationController
  def index
    location = params[:location]  

    if location
      begin
        photo = UnsplashFacade.get_image(location)
        render json: BackgroundSerializer.new(photo)
      rescue
        render json: ErrorSerializer.format_errors("Location parameter is required"), status: 400
      end
    end
  end
end