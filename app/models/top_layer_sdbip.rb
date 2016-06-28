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

  validates :department_id, :mtas_indicator_id, :mscore_classification_id, :national_outcome_id,:ndp_objective_id,
  :predetermined_objective_id, :strategic_objective_id,:kpa_id, :ward_id,:area_id, :kpi_owner_id, :kpi_calculation_type_id, :kpi_target_type_id, :presence => true
  
end
