json.array!(@kpi_calculation_types) do |kpi_calculation_type|
  json.extract! kpi_calculation_type, :id, :name, :code
  json.url kpi_calculation_type_url(kpi_calculation_type, format: :json)
end
