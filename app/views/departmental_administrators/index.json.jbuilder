json.array!(@departmental_administrators) do |departmental_administrator|
  json.extract! departmental_administrator, :id, :department_id, :user_id, :can_create, :can_edit, :can_update, :can_approve
  json.url departmental_administrator_url(departmental_administrator, format: :json)
end
