json.array!(@wards) do |ward|
  json.extract! ward, :id, :name, :area_id, :mun_ref
  json.url ward_url(ward, format: :json)
end
