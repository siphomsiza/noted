class ActivityLog < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  belongs_to :user
end
