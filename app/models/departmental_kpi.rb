class DepartmentalKpi < ActiveRecord::Base
  belongs_to :department
	has_many :activities
	belongs_to :list
	belongs_to :subdepartment
	belongs_to :kpi_owner
	belongs_to :predetermined_objective
	belongs_to :mscore_classification
	belongs_to :national_outcome
	belongs_to :strategic_objective
	belongs_to :kpa
	belongs_to :area
	belongs_to :funding_source
	belongs_to :kpi_calculation_type
	belongs_to :kpi_concept
	belongs_to :kpi_target_type
	belongs_to :kpi_type
	belongs_to :mtas_indicator
	belongs_to :ndp_objective
	belongs_to :provincial_strategic_outcome
	belongs_to :reporting_category
	belongs_to :revenue_by_source
	belongs_to :risk_rating
	belongs_to :strategic_objective
	belongs_to :ward
	belongs_to :departmental_idp_objective
end
