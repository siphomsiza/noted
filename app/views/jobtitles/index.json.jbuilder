json.array!(@jobtitles) do |jobtitle|
  json.extract! jobtitle, :id, :title
  json.url jobtitle_url(jobtitle, format: :json)
end
