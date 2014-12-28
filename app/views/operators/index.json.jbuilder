json.array!(@operators) do |operator|
  json.extract! operator, :id
  json.url operator_url(operator, format: :json)
end
