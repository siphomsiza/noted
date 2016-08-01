json.array!(@kpi_concepts) do |kpi_concept|
  json.extract! kpi_concept, :id, :name, :code
  json.url kpi_concept_url(kpi_concept, format: :json)
end
