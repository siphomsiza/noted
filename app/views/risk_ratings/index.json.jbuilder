json.array!(@risk_ratings) do |risk_rating|
  json.extract! risk_rating, :id, :name, :code
  json.url risk_rating_url(risk_rating, format: :json)
end
