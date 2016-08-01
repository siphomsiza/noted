json.array!(@national_outcomes) do |national_outcome|
  json.extract! national_outcome, :id, :name
  json.url national_outcome_url(national_outcome, format: :json)
end
