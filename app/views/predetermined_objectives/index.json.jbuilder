json.array!(@predetermined_objectives) do |predetermined_objective|
  json.extract! predetermined_objective, :id, :name
  json.url predetermined_objective_url(predetermined_objective, format: :json)
end
