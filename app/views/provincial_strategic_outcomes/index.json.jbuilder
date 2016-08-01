json.array!(@provincial_strategic_outcomes) do |provincial_strategic_outcome|
  json.extract! provincial_strategic_outcome, :id, :name
  json.url provincial_strategic_outcome_url(provincial_strategic_outcome, format: :json)
end
