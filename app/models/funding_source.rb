class FundingSource < ActiveRecord::Base
	establish_connection($current_session_db)
	include PublicActivity::Common

end
