json.array!(@kpi_types) do |kpi_type|
  json.extract! kpi_type, :id, :name
  json.url kpi_type_url(kpi_type, format: :json)
end
