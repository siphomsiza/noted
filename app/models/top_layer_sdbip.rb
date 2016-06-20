class TopLayerSdbip < ActiveRecord::Base
  belongs_to :department
  belongs_to :mscore_classification
  belongs_to :national_outcome
  belongs_to :kpi_target_type
  belongs_to :kpa
  belongs_to :predetermined_objective
  belongs_to :strategic_objective
  belongs_to :ndp_objective
  belongs_to :ward
  belongs_to :area
  belongs_to :kpi_owner
  belongs_to :mtas_indicator
  belongs_to :kpi_calculation_type
end
