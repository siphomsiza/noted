class KpiOwner < ActiveRecord::Base
	belongs_to :user
	has_many :departmental_sdbips
end
