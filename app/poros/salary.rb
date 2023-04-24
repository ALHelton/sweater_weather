class Salary
  attr_reader :id,
              :destination,
              :forecast,
              :salaries

  def initialize(destination, forecast, salaries)
    @id = nil
    @destination = destination
    @forecast = forecast
    @salaries = salaries
  end
end