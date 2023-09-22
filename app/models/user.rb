class User < ApplicationRecord
  before_create :generate_api_key

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_secure_password

  private
  
  def generate_api_key
    self.api_key = SecureRandom.hex
  end
end
