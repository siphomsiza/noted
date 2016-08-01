json.array!(@mscore_classifications) do |mscore_classification|
  json.extract! mscore_classification, :id, :name
  json.url mscore_classification_url(mscore_classification, format: :json)
end
