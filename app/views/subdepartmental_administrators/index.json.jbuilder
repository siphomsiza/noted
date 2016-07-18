json.array!(@subdepartmental_administrators) do |subdepartmental_administrator|
  json.extract! subdepartmental_administrator, :id, :department_id, :user_id, :can_create, :can_edit, :can_update, :can_approve
  json.url subdepartmental_administrator_url(subdepartmental_administrator, format: :json)
end
