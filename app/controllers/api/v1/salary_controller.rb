class Api::V1::SalaryController < ApplicationController
  def index
    salary = TeleportFacade.new.get_city_salaries(params[:destination])
    render json: SalarySerializer.new(salary)
  end
end