class Ward < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	belongs_to :area
	has_many :departmental_sdbips
	has_many :capital_projects
end
