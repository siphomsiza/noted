json.array!(@funding_sources) do |funding_source|
  json.extract! funding_source, :id, :name
  json.url funding_source_url(funding_source, format: :json)
end
