json.array!(@reporting_categories) do |reporting_category|
  json.extract! reporting_category, :id, :name
  json.url reporting_category_url(reporting_category, format: :json)
end
