class ReportingCategory < ActiveRecord::Base
	include PublicActivity::Common
	has_many :departmental_sdbips
end
