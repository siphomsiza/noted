class SubdepartmentalAdministrator < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  belongs_to :subdepartment
  belongs_to :user
  validates_presence_of :user_id
end
