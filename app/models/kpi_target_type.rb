class KpiTargetType < ActiveRecord::Base
	establish_connection($current_session_db)
	include PublicActivity::Common
	has_one :top_layer_sdbip
end
