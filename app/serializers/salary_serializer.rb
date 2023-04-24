class SalarySerializer
  include JSONAPI::Serializer

  set_id :id
  set_type :salaries
  attributes :destination, :forecast, :salaries
end