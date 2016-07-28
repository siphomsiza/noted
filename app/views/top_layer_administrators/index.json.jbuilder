json.array!(@top_layer_administrators) do |top_layer_administrator|
  json.extract! top_layer_administrator, :id, :user_id, :can_edit, :can_create, :can_approve, :can_update
  json.url top_layer_administrator_url(top_layer_administrator, format: :json)
end
