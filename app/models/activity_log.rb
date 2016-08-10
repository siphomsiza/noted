class ActivityLog < ActiveRecord::Base
  establish_connection($current_session_db)
  belongs_to :user
end
