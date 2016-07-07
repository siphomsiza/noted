class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :departmental_sdbip
  validates :user_id, presence: true
  validates :departmental_sdbip_id, presence: true

  def self.filter_audit_logs(top_layer_kpi_ref_filters,capital_project_filters,selected_columns,department_id,subdepartment_id,
    kpi_ref_number,predetermined_objective_id,
    kpi_owner_id,kpi,
    unit_of_measurement,
    mscore_classification_id,strategic_objective_id,
    source_of_evidence,baseline,
    annual_target,revised_target,
    national_kpa_id,ndp_objective_id,
    kpi_concept_id,kpi_type_id,
    provincial_strategic_outcome_id,ward_id,
    area_id,performance_standard,past_year_performance,
    impact,
    kpi_calculation_type_id,kpi_target_type_id)

    @audits = DepartmentalSdbip.includes(:activities)
    audit_columns = []
    audit_columns_headers = []

    if !top_layer_kpi_ref_filters.blank?

      if top_layer_kpi_ref_filters == "all kpis"

      elsif top_layer_kpi_ref_filters == "not linked to top layer kpi"
          @audits = @audits.where(:top_layer_kpi_ref=> nil)
      elsif top_layer_kpi_ref_filters == "linked to top layer kpi"
          @audits = @audits.where.not(:top_layer_kpi_ref=> nil)
      end
    end

    if !capital_project_filters.blank?

      if capital_project_filters == "all kpis"

      elsif capital_project_filters == "operational kpis only"
          @audits = @audits.where(:departmental_sdbip =>{:kpi_type_id => 2 })
      elsif capital_project_filters == "kpis associated with capital projects only"
          @audits = @audits.where.not(:capital_project_id=> nil)
      end

    end

    if selected_columns.include?("Department")
      audit_columns.push("departmental_sdbip.department_name")
      audit_columns_headers.push("Department")
      if !department_id.blank?
        departments_value = department_id
        @audits = @audits.where(:department_id => departments_value.split(""))
      end
    end

    if selected_columns.include?("Sub-Department")
      audit_columns.push("departmental_sdbip.subdepartment_name")
      audit_columns_headers.push("Sub-Department")
      if !subdepartment_id.blank?
        subdepartments_value = subdepartment_id
        @audits = @audits.where(:subdepartment_id => subdepartments_value.split(""))
      end
    end

    if selected_columns.include?("KPI Owner")
      audit_columns.push("departmental_sdbip.kpi_owner.name")
      audit_columns_headers.push("KPI Owner")
      if !kpi_owner_id.blank?
        kpi_owner_values = kpi_owner_id
        @audits = @audits.where(:kpi_owner_id => kpi_owner_values.split(""))

      end
    end

    if selected_columns.include?("KPI Ref Number")
      audit_columns.push("departmental_sdbip.kpi_ref_number")
      audit_columns_headers.push("KPI Ref Number")
      if !kpi_ref_number.blank?
        kpi_ref_number_values = kpi_ref_number
        @audits = @audits.where(:kpi_ref_number => kpi_ref_number_values.split(""))

      end
    end
    if selected_columns.include?("Revised Target")
      audit_columns.push("departmental_sdbip.revised_target")
      audit_columns_headers.push("Revised Target")
      if !revised_target.blank?
        revised_target_values = revised_target
        @audits = @audits.where(:revised_target => revised_target_values.split(""))

      end
    end
    if selected_columns.include?("KPI Concept")
      audit_columns.push("departmental_sdbip.kpi_concept.name")
      audit_columns_headers.push("KPI Concept")
      if !kpi_concept_id.blank?
        kpi_concept_values = kpi_concept_id
        @audits = @audits.where(:kpi_concept_id => kpi_concept_values.split(""))

      end
    end
    if selected_columns.include?("KPI Type")
      audit_columns.push("departmental_sdbip.kpi_type.name")
      audit_columns_headers.push("KPI Type")
      if !kpi_type_id.blank?
        kpi_type_values = kpi_type_id
        @audits = @audits.where(:kpi_type_id => kpi_type_values.split(""))

      end
    end
    if selected_columns.include?("KPI Calculation Type")
      audit_columns.push("departmental_sdbip.kpi_calculation_type.name")
      audit_columns_headers.push("KPI Calculation Type")
      if !kpi_calculation_type_id.blank?
        kpi_calculation_type_values = kpi_calculation_type_id
        @audits = @audits.where(:kpi_calculation_type_id => kpi_calculation_type_values.split(""))
      end
    end

    if selected_columns.include?("Top Layer KPI Ref")
      audit_columns.push("departmental_sdbip.top_layer_kpi_ref")
      audit_columns_headers.push("Top Layer KPI Ref")
    end
    if selected_columns.include?("Baseline")
      audit_columns.push("departmental_sdbip.baseline")
      audit_columns_headers.push("Baseline")
      if !baseline.blank?
        baseline_values = baseline
        @audits = @audits.where(:baseline => baseline_values.split(""))

      end
    end
    if selected_columns.include?("Ward")
      audit_columns.push("departmental_sdbip.ward.name")
      audit_columns_headers.push("Ward")
      if !ward_id.blank?
        ward_values = ward_id
        @audits = @audits.where(:ward_id => ward_values.split(""))

      end

    end
    if selected_columns.include?("Area")
      audit_columns.push("departmental_sdbip.area.name")
      audit_columns_headers.push("Area")
      if !area_id.blank?
        area_values = area_id
        @audits = @audits.where(:area_id => area_values.split(""))

      end
    end

    if selected_columns.include?("Budget")
      audit_columns.push("departmental_sdbip.budget")
      audit_columns_headers.push("Budget")
    end
    if ("KPI").in?selected_columns
      audit_columns.push("departmental_sdbip.kpi")
      audit_columns_headers.push("KPI")
      if !kpi.blank?
        kpi_values = kpi
        @audits = @audits.where(:id => kpi_values.split(""))

      end
    end
    if selected_columns.include?("KPA")
      audit_columns.push("departmental_sdbip.kpa.name")
      audit_columns_headers.push("KPA")
      if !national_kpa_id.blank?
        kpa_values = kpa_values
        @audits = @audits.where(:kpa_id => kpa_values.split(""))

      end
    end
    if selected_columns.include?("Previous Year Actual Performance")
      audit_columns.push("departmental_sdbip.past_year_performance")
      audit_columns_headers.push("Previous Year Actual Performance")

      if !past_year_performance.blank?
        past_year_performance_values = past_year_performance_values
        @audits = @audits.where(:id => past_year_performance_values.split(""))

      end
    end
    if selected_columns.include?("Provincial Strategic Objectives")
      audit_columns.push("departmental_sdbip.provincial_strategic_outcome.name")
      audit_columns_headers.push("Provincial Strategic Objectives")
      if !provincial_strategic_outcome_id.blank?
        provincial_strategic_outcome_values = provincial_startegic_id
        @audits = @audits.where(:provincial_strategic_outcome_id => provincial_strategic_outcome_values.split(""))

      end
    end
    if selected_columns.include?("Pre-determined Objectives")
      audit_columns.push("departmental_sdbip.predetermined_objective.name")
      audit_columns_headers.push("Pre-determined Objectives")

      if !predetermined_objective_id.blank?
        predetermined_objectives_values = predetermined_objective_id
        @audits = @audits.where(:predetermined_objective_id => predetermined_objectives_values.split(""))

      end
    end
      if selected_columns.include?("GFS Classification")
        audit_columns.push("departmental_sdbip.mscore_classification.name")
        audit_columns_headers.push("GFS Classification")
        if !mscore_classification_id.blank?
          mscore_classification_values = mscore_classification_id
          @audits = @audits.where(:mscore_classification_id => mscore_classification_values.split(""))

        end
      end

      if selected_columns.include?("NDP Objectives")
        audit_columns.push("departmental_sdbip.ndp_objective.name")
        audit_columns_headers.push("NDP Objectives")
        if !ndp_objective_id.blank?
          ndp_objective_values = ndp_objective_id
          @audits = @audits.where(:ndp_objective_id => ndp_objective_values.split(""))

        end
      end

      if selected_columns.include?("Strategic Objectives")
        audit_columns.push("departmental_sdbip.strategic_objective.name")
        audit_columns_headers.push("Strategic Objectives")
        if !strategic_objective_id.blank?
          strategic_objective_values = strategic_objective_id
          @audits = @audits.where(:strategic_objective_id => strategic_objective_values.split(""))
        end
      end

      if selected_columns.include?("Impact")
        audit_columns.push("departmental_sdbip.impact")
        audit_columns_headers.push("Impact")
        if !impact.blank?
          impact_values = impact_values
          @audits = @audits.where(:impact => impact_values.split(""))

        end
      end
      if selected_columns.include?("Proof of evidence")
        audit_columns.push("departmental_sdbip.source_of_evidence")
        audit_columns_headers.push("Proof of Evidence")
        if !source_of_evidence.blank?
          source_of_evidence_values = source_of_evidence
          @audits = @audits.where(:source_of_evidence => source_of_evidence_values.split(""))

        end
      end
      if selected_columns.include?("Unit of Measurement")
        audit_columns.push("departmental_sdbip.unit_of_measurement")
        audit_columns_headers.push("Unit of Measurement")
        if !unit_of_measurement.blank?
          unit_of_measurement_values = unit_of_measurement_values
          @audits = @audits.where(:unit_of_measurement => unit_of_measurement_values.split(""))
        end

      end
      if selected_columns.include?("National Outcome")
        audit_columns.push("departmental_sdbip.national_outcome.name")
        audit_columns_headers.push("National Outcome")
      end
      if selected_columns.include?("Annual Target")
        audit_columns.push("departmental_sdbip.annual_target")
        audit_columns_headers.push("Annual Target")
        if !annual_target.blank?
          annual_target_values = annual_target
          @audits = @audits.where(:annual_target => annual_target_values.split(""))

        end
      end
      if selected_columns.include?("Reporting Category")
         audit_columns.push("departmental_sdbip.reporting_category.name")
         audit_columns_headers.push("Reporting Category")
      end
      if selected_columns.include?("IDP Ref")
       audit_columns.push("departmental_sdbip.idp_ref")
       audit_columns_headers.push("IDP Ref")
      end
      if selected_columns.include?("Performance Standard")
  		 audit_columns.push("departmental_sdbip.performance_standard")
  		 audit_columns_headers.push("Performance Standard")
  		end
  		if selected_columns.include?("Performance Comment")
  		 audit_columns.push("departmental_sdbip.performance_comments")
  		 audit_columns_headers.push("Performance Comment")
  		end
  		if selected_columns.include?("Corrective Measures")
  		 audit_columns.push("departmental_sdbip.corrective_measures")
  		 audit_columns_headers.push("Corrective Measures")
  		end
  		if selected_columns.include?("Target, Actual & Results")
  		 audit_columns.push("departmental_sdbip.annual_target")
  		 audit_columns_headers.push("Target")
  		end
  		if selected_columns.include?("Proof of evidence")
  		 audit_columns.push("departmental_sdbip.first_quarter_poe")
  		 audit_columns_headers.push("Proof of evidence")
  		end
   $selected_array_of_values = audit_columns
   $selected_array_of_headers = audit_columns_headers
   @audit_logs = @audits

  end

end
