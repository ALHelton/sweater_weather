class Api::V0::SessionsController < ApplicationController
  
  def create
    if session_params[:email].present? && session_params[:password].present?
      user = User.find_by(email: session_params[:email])
    
      if user != nil && user.authenticate(params[:password])
        render json: SessionSerializer.new(user), status: 200
      else
        render json: { error: "Credentials are Invalid" }, status: 401
      end
    else
      render json: { error: "One or more Credentials are missing" }, status: 400
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end