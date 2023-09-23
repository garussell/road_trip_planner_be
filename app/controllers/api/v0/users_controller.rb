class Api::V0::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    
    if @user.save 
      render json: UserSerializer.new(@user), status: 201
    elsif User.exists?(email: user_params[:email])
      render json: ErrorSerializer.format_errors("Email already exists"), status: 422
    else
      render json: ErrorSerializer.format_errors("Invalid Parameters"), status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
