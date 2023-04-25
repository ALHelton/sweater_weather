class Api::V0::SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: session_params[:email])
    
    if session_params[:email].present? && session_params[:password].present?
      if user != nil && user.authenticate(params[:password])
        render json: SessionSerializer.new(user), status: 200
      else
        render json: { error: user.errors.full_messages.to_sentence }, status: 401
      end
    else
      render json: { error: user.errors.full_messages.to_sentence }, status: 400
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end