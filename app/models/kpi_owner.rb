class KpiOwner < ActiveRecord::Base
	establish_connection($current_session_db)
	include PublicActivity::Common
	belongs_to :user
	has_many :departmental_sdbips

end
