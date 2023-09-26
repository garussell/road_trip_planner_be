# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should have_secure_password }
  end

  describe 'instance methods' do
    it 'can create an api_key' do
      user = User.create!(email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
      expect(user.api_key).to be_a(String)
      expect(user.api_key.length).to eq(32)
    end
  end
end
