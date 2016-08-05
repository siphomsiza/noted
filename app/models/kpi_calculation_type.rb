class KpiCalculationType < ActiveRecord::Base
	include PublicActivity::Common
	has_many :departmental_sdbips
	has_one :top_layer_sdbip
end
