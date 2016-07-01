class Kpa < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :list
	has_many :departmental_sdbips
end
