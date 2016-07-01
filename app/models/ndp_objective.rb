class NdpObjective < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :list
	has_many :departmental_sdbips
	has_one :top_layer_sdbip
end
