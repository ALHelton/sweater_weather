class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: trip_params[:api_key])
    if user.present?
      trip = RoadTripFacade.new.trip_info(trip_params[:origin], trip_params[:destination])
      render json: RoadTripSerializer.new(trip), status: 201
    else
      render json: { error: "Invalid Credentials" }, status: 401
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end