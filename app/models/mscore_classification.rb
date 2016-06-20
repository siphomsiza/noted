class MscoreClassification < ActiveRecord::Base
	has_many :departmental_sdbips
	has_many :capital_projects
	has_many :monthly_cashflows
end
