class Ward < ActiveRecord::Base
	belongs_to :area
	has_many :departmental_sdbips
	has_many :capital_projects
end
