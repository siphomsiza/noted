class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :departmental_sdbip
  validates :user_id, presence: true
  validates :departmental_sdbip_id, presence: true

  def self.filter_audit_logs(department_id,subdepartment_id,
    kpi_ref_number,predetermined_objective_id,
    kpi_owner_id,kpi,
    unit_of_measurement,
    mscore_classification_id,strategic_objective_id,
    source_of_evidence,baseline,
    annual_target,revised_target,
    national_kpa_id,ndp_objective_id,
    kpi_concept_id,kpi_type_id,
    provincial_strategic_outcome_id,ward_id,
    area_id,performance_standard,
    kpi_calculation_type_id,kpi_target_type_id)
    @audits = DepartmentalSdbip.includes(:activities)
    audit_columns = []

    if !department_id.blank?
      departments_value = department_id
      @audits = @audits.where(:department_id => departments_value.split(""))
      audit_columns.push("DepartmentalSdbip.department_name")
    end
    if !subdepartment_id.blank?
      subdepartments_value = subdepartment_id
      @audits = @audits.where(:subdepartment_id => subdepartments_value.split(""))
      audit_columns.push("DepartmentalSdbip.subepartment_name")

    end
    if !kpi_owner_id.blank?
      kpi_owner_values = kpi_owner_id
      @audits = @audits.where(:kpi_owner_id => kpi_owner_values.split(""))
      audit_columns.push("DepartmentalSdbip.kpi_owner.name")
    end

    #if !kpi_ref_number_id.blank?
      #kpi_ref_number_values = kpi_ref_number_id
     #@audits = @audits.include.where(kpi_ref_number => kpi_ref_number_values.split(""))
    #end
    if !revised_target.blank?
      #revised_target_values = revised_target
     #@audits = @audits.include.where(revised_target => revised_target_values.split(""))
    end
    if !kpi_concept_id.blank?
      kpi_concept_values = kpi_concept_id
      @audits = @audits.where(:kpi_concept_id => kpi_concept_values.split(""))
      audit_columns.push("DepartmentalSdbip.kpi_concept.name")
    end
    if !kpi_type_id.blank?
      kpi_type_values = kpi_type_id
      @audits = @audits.where(:kpi_type_id => kpi_type_values.split(""))
      audit_columns.push("DepartmentalSdbip.kpi_type.name")
    end

    if !kpi_calculation_type_id.blank?
      kpi_calculation_type_values = kpi_calculation_type_id
      @audits = @audits.where(:kpi_calculation_type_id => kpi_calculation_type_values.split(""))
      audit_columns.push("DepartmentalSdbip.kpi_calculation_type.name")
    end

    #if !top_layer_kpi_ref.blank?
      #top_layer_kpi_ref_values = top_layer_kpi_ref_values
     #@audits = @audits.include.where(top_layer_kpi_ref => top_layer_kpi_ref_values.split(""))
    #end
    #if data_value.include?('Baseline')
      #baseline_values = baseline_values
     #@audits = @audits.include.where(baseline => baseline_values.split(""))
    #end
    if !ward_id.blank?
      ward_values = ward_id
      @audits = @audits.where(:ward_id => ward_values.split(""))
      audit_columns.push("DepartmentalSdbip.ward.name")
    end
    if !area_id.blank?
      area_values = area_id
      @audits = @audits.where(:area_id => area_values.split(""))
      audit_columns.push("DepartmentalSdbip.area.name")
    end

    #if data_value.include?('Budget')
      #budget_values = budget_values
     #@audits = @audits.include.where(budget => budget_values.split(""))
    #end
    #if data_value.include?('KPI')
      #kpi_values = kpi_values
      #@audits = @audits.include.where(kpi => kpi_values.split(""))
    #end
    #if data_value.include?('KPA')
      #kpa_values = kpa_values
      #@audits = @audits.include.where(kpa_id => kpa_values.split(""))
    #end
    #if data_value.include?('Past Year Performance')
      #past_year_performance_values = past_year_performance_values
     #@audits = @audits.include.where(past_year_performance => past_year_performance_values.split(""))
    #end
    #if data_value.include?('Provincial Strategic Outcome')
      #provincial_strategic_outcome_values = provincial_startegic_values
      #@audits = @audits.include.where(provincial_strategic_outcome_id => provincial_strategic_outcome_values.split(""))
    #end
    if !predetermined_objective_id.blank?
      predetermined_objectives_values = predetermined_objective_id
      @audits = @audits.where(:predetermined_objective_id => predetermined_objectives_values.split(""))
      audit_columns.push("DepartmentalSdbip.predetermined_objective.name")
    end
    #if !reporting_category_id.blank?
    #   reporting_category_values = reporting_category_id
    #   @audits = @audits.include.where(reporting_category_id => reporting_category_values.split(""))
    #end
    if !mscore_classification_id.blank?
      mscore_classification_values = mscore_classification_id
      @audits = @audits.where(:mscore_classification_id => mscore_classification_values.split(""))
      audit_columns.push("DepartmentalSdbip.mscore_classification.name")
    end

    if !ndp_objective_id.blank?
      ndp_objective_values = ndp_objective_id
      @audits = @audits.where(:ndp_objective_id => ndp_objective_values.split(""))
      audit_columns.push("DepartmentalSdbip.ndp_objective.name")
    end
    #if data_value.include?('IDP Ref')
      #idp_ref_values = idp_ref_values
     #@audits = @audits.include.where(idp_ref => idp_ref_values.split(""))
    #end
    if !strategic_objective_id.blank?
      strategic_objective_values = strategic_objective_id
      @audits = @audits.where(:strategic_objective_id => strategic_objective_values.split(""))
      audit_columns.push("DepartmentalSdbip.strategic_objective.name")
    end
    #if data_value.include?('Impact')
      #impact_values = impact_values
     #@audits = @audits.include.where(impact => impact_values.split(""))
    #end
    #if data_value.include?('Source of Evidence')
      #source_of_evidence_values = source_of_evidence_values
      #@audits = @audits.include.where(source_of_evidence => source_of_evidence_values.split(""))
    #end
    #if data_value.include?('Unit of Measurement')
      #unit_of_measurement_values = unit_of_measurement_values
     #@audits = @audits.include.where(unit_of_measurement => unit_of_measurement_values.split(""))
    #end
    #if !national_outcome_id.blank?
    #  national_outcome_values = national_outcome_id
    #  @audits = @audits.include.where(national_outcome_id => national_outcome_values.split(""))
    #  audit_columns.push("DepartmentalSdbip.national_outcome.name")
    #end
    #if data_value.include?('Annual Target')
      #annual_target_values = annual_target_values
     #@audits = @audits.include.where(annual_target => annual_target_values.split(""))
    #end
   @audit_logs = @audits
  end

end
