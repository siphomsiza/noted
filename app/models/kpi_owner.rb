class KpiOwner < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :list
	has_many :departmental_sdbips
	belongs_to :subdepartment
	belongs_to :top_layer_sdbip
end
