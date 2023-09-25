class Image
  attr_reader :id, :image

  def initialize(location, data)
    @id = nil
    @location = location
    @image = image_details(data)
  end

  def image_details(data)
    {
      location: @location,
      image_url: data[:results].first[:urls][:raw],
      credit: {
        source: "unsplash.com",
        author: data[:results].first[:user][:name],
        logo: data[:results].first[:user][:profile_image][:small]
      }
    }
  end
end