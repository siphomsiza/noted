json.array!(@kpas) do |kpa|
  json.extract! kpa, :id, :name
  json.url kpa_url(kpa, format: :json)
end
