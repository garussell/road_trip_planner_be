class UserSerializer
include JSONAPI::Serializer
  set_type 'users'

  attributes :email, :api_key
end