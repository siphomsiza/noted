class Ward < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :area
	has_many :departmental_sdbips
	has_many :capital_projects
end
