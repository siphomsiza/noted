json.array!(@kpi_owners) do |kpi_owner|
  json.extract! kpi_owner, :id, :user_id, :title
  json.url kpi_owner_url(kpi_owner, format: :json)
end
