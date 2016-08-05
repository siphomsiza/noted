class KpiTargetType < ActiveRecord::Base
	include PublicActivity::Common
	has_one :top_layer_sdbip
end
