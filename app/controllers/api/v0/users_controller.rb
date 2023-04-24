class Api::V0::UsersController < ApplicationController
  def create
    user_params[:email] = user_params[:email].downcase
    user = User.new(user_params)

    if user.password == user.password_confirmation
      user.save
      render json: UserSerializer.new(user), status: 201
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end