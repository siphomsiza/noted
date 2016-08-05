class KpiOwner < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :user
	has_many :departmental_sdbips

end
