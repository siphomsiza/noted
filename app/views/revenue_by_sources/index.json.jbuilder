json.array!(@revenue_by_sources) do |revenue_by_source|
  json.extract! revenue_by_source, :id, :vote_number, :line_item, :July, :August, :September, :October, :November, :December, :January, :February, :March, :April, :May, :June
  json.url revenue_by_source_url(revenue_by_source, format: :json)
end
