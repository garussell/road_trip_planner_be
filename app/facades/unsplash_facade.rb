# frozen_string_literal: true

class UnsplashFacade
  def self.get_image(location)
    photo = UnsplashService.get_image(location)
    Image.new(location, photo)
  end
end
