class ProvincialStrategicOutcome < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	has_many :departmental_sdbips
end
