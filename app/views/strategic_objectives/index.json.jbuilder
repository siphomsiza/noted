json.array!(@strategic_objectives) do |strategic_objective|
  json.extract! strategic_objective, :id, :name
  json.url strategic_objective_url(strategic_objective, format: :json)
end
