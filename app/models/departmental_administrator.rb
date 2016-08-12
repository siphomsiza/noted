class DepartmentalAdministrator < ActiveRecord::Base
  establish_connection($current_session_db)
  belongs_to :department
  belongs_to :user
  validates_presence_of :user_id
end
