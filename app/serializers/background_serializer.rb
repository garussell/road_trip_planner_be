# frozen_string_literal: true

class BackgroundSerializer
  include JSONAPI::Serializer

  set_type :image

  attributes :image
end
