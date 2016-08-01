json.array!(@mtas_indicators) do |mtas_indicator|
  json.extract! mtas_indicator, :id, :name
  json.url mtas_indicator_url(mtas_indicator, format: :json)
end
