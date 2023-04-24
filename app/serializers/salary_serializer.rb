class ForecastSerializer
  include JSONAPI::Serializer

  set_id :id
  set_type :salary
  attributes :destination, :forecast, :salaries
end