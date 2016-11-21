class Role < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	belongs_to :user
	validates :user_id, presence: true, numericality: true
end
