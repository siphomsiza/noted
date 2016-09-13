class Role < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	belongs_to :user
	belongs_to :department
	belongs_to :subdepartment
	validates :user_id, presence: true, numericality: true
end
