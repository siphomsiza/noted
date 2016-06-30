class TopLayerSdbip < ActiveRecord::Base
  belongs_to :department
  has_one :mscore_classification
  has_one :national_outcome
  has_one :kpi_target_type
  has_one :kpa
  has_one :predetermined_objective
  has_one :strategic_objective
  has_one :ndp_objective
  has_one :ward
  has_one :area
  has_one :kpi_owner
  has_one :mtas_indicator
  has_one :kpi_calculation_type

  validates :department_id, :mtas_indicator_id, :mscore_classification_id, :national_outcome_id,:ndp_objective_id,
  :predetermined_objective_id, :strategic_objective_id,:kpa_id, :ward_id,:area_id, :kpi_owner_id, :kpi_calculation_type_id, :kpi_target_type_id, :presence => true

end
