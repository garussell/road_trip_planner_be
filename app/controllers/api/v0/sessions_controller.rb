# frozen_string_literal: true

module Api
  module V0
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: user_params[:email])

        if user&.authenticate(user_params[:password])
          render json: UserSerializer.new(user), status: 200
        else
          render json: ErrorSerializer.format_errors('Invalid email or password'), status: 422
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
