class MscoreClassification < ActiveRecord::Base
	establish_connection($current_session_db)
	include PublicActivity::Common
	has_many :departmental_sdbips
	has_many :capital_projects
	has_many :monthly_cashflows

end
