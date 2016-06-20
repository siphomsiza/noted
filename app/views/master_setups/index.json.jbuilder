json.array!(@master_setups) do |master_setup|
  json.extract! master_setup, :id, :municipality
  json.url master_setup_url(master_setup, format: :json)
end
