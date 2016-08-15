class NdpObjective < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	has_many :departmental_sdbips
	has_one :top_layer_sdbip
end
