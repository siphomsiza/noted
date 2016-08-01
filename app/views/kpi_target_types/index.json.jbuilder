json.array!(@kpi_target_types) do |kpi_target_type|
  json.extract! kpi_target_type, :id, :name, :code
  json.url kpi_target_type_url(kpi_target_type, format: :json)
end
