json.array!(@ndp_objectives) do |ndp_objective|
  json.extract! ndp_objective, :id, :name
  json.url ndp_objective_url(ndp_objective, format: :json)
end
