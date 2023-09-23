class Api::V0::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if user_params_valid? && @user.save 
      render json: UserSerializer.new(@user), status: 201
    else 
      render json: ErrorSerializer.format_errors("Invalid Parameters"), status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_params_valid?
    !user_params[:email].empty? && !user_params[:password].empty? && user_params[:password] == user_params[:password_confirmation]
  end
end
