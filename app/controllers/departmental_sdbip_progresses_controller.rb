class DepartmentalSdbipProgressesController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:export]
  before_action :admin_user,     only: [:index,:show,:export]
  before_action :kpi_owner_user,     only: [:index,:show,:export]
  skip_before_filter  :verify_authenticity_token

  def index
    @audit_logs = []
    selected_values = []
    selected_headings = []
    if params[:selected_columns] && params[:department_id] || params[:department_id] || params[:subdepartment_id] || params[:kpi_ref_number] || params[:predetermined_objective_id] || params[:kpi_owner_id] || params[:kpi] || params[:unit_of_measurement] || params[:mcore_classification_id] || params[:strategic_objective_id] || params[:source_of_evidence] || params[:baseline] || params[:annual_target] || params[:revised_target] || params[:national_kpa_id] || params[:ndp_objective_id] || params[:kpi_concept_id] || params[:kpi_type_id] || params[:provincial_strategic_outcome_id] || params[:ward_id] || params[:area_id] || params[:performance_standard] || params[:kpi_calculation_type_id] || params[:kpi_target_type_id]
      puts "welcome to rails"
      puts params[:selected_columns]
      puts "we made it"
      @audit_logs = Activity.filter_audit_logs(params[:department_id],
      params[:subdepartment_id],
      params[:kpi_ref_number],
      params[:predetermined_objective_id],
      params[:kpi_owner_id],
      params[:kpi],
      params[:unit_of_measurement],
      params[:mcore_classification_id],
      params[:strategic_objective_id],
      params[:source_of_evidence],
      params[:baseline],
      params[:annual_target],
      params[:revised_target],
      params[:national_kpa_id],
      params[:ndp_objective_id],
      params[:kpi_concept_id],
      params[:kpi_type_id],
      params[:provincial_strategic_outcome_id],
      params[:ward_id],params[:area_id],
      params[:performance_standard],
      params[:kpi_calculation_type_id],
      params[:kpi_target_type_id])
      if !@audit_logs.blank?
        @audit_logs = @audit_logs.paginate(page: params[:page],per_page: 15)
      end
    end
   if params[:data_value]
      selected_headings = params[:data_value]
     @sdbip_progresses = DepartmentalSdbip.all
     if params[:data_value].include?('Department')
       departments_value = params[:departments_value]
       @sdbip_progresses = @sdbip_progresses.where(:department_id => departments_value.split(""))
       selected_values.push("DepartmentalSdbip.department_name")
     end
     if params[:data_value].include?('Sub-Department')
       subdepartments_value = params[:subdepartments_value]
       @sdbip_progresses = @sdbip_progresses.where(:subdepartment_id => subdepartments_value.split(""))
       selected_values.push("DepartmentalSdbip.subepartment_name")

     end
     if params[:data_value].include?('KPI Owner')
       kpi_owner_values = params[:kpi_owner_values]
       @sdbip_progresses = @sdbip_progresses.where(:kpi_owner_id => kpi_owner_values.split(""))
       selected_values.push("DepartmentalSdbip.kpi_owner.name")
     end

     if params[:data_value].include?('KPI Ref Number')
       #kpi_ref_number_values = params[:kpi_ref_number_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:kpi_ref_number => kpi_ref_number_values.split(""))
     end
     if params[:data_value].include?('Revised Target')
       #revised_target_values = params[:revised_target_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:revised_target => revised_target_values.split(""))
     end
     if params[:data_value].include?('KPI Concept')
       kpi_concept_values = params[:kpi_concept_values]
       @sdbip_progresses = @sdbip_progresses.where(:kpi_concept_id => kpi_concept_values.split(""))
       selected_values.push("DepartmentalSdbip.kpi_concept.name")
     end
     if params[:data_value].include?('KPI Type')
       kpi_type_values = params[:kpi_type_values]
       @sdbip_progresses = @sdbip_progresses.where(:kpi_type_id => kpi_type_values.split(""))
       selected_values.push("DepartmentalSdbip.kpi_type.name")
     end

     if params[:data_value].include?('KPI Calculation Type')
       kpi_calculation_type_values = params[:kpi_calculation_type_values]
       @sdbip_progresses = @sdbip_progresses.where(:kpi_calculation_type_id => kpi_calculation_type_values.split(""))
       selected_values.push("DepartmentalSdbip.kpi_calculation_type.name")
     end

     if params[:data_value].include?('Top Layer KPI Ref')
       #top_layer_kpi_ref_values = params[:top_layer_kpi_ref_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:top_layer_kpi_ref => top_layer_kpi_ref_values.split(""))
     end
     if params[:data_value].include?('Baseline')
       #baseline_values = params[:baseline_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:baseline => baseline_values.split(""))
     end
     if params[:data_value].include?('Wards')
       ward_values = params[:ward_values]
       @sdbip_progresses = @sdbip_progresses.where(:ward_id => ward_values.split(""))
       selected_values.push("DepartmentalSdbip.ward.name")
     end
     if params[:data_value].include?('Area')
       area_values = params[:area_values]
       @sdbip_progresses = @sdbip_progresses.where(:area_id => area_values.split(""))
       selected_values.push("DepartmentalSdbip.area.name")
     end

     if params[:data_value].include?('Budget')
       #budget_values = params[:budget_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:budget => budget_values.split(""))
     end
     if params[:data_value].include?('KPI')
       #kpi_values = params[:kpi_values]
       #@sdbip_progresses = @sdbip_progresses.where(:kpi => kpi_values.split(""))
     end
     if params[:data_value].include?('KPA')
       #kpa_values = params[:kpa_values]
       #@sdbip_progresses = @sdbip_progresses.where(:kpa_id => kpa_values.split(""))
     end
     if params[:data_value].include?('Past Year Performance')
       #past_year_performance_values = params[:past_year_performance_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:past_year_performance => past_year_performance_values.split(""))
     end
     if params[:data_value].include?('Provincial Strategic Outcome')
       #provincial_strategic_outcome_values = params[:provincial_startegic_values]
       #@sdbip_progresses = @sdbip_progresses.where(:provincial_strategic_outcome_id => provincial_strategic_outcome_values.split(""))
     end
     if params[:data_value].include?('Predetermined Objectives')
       predetermined_objectives_values = params[:predetermined_objectives_values]
       @sdbip_progresses = @sdbip_progresses.where(:predetermined_objective_id => predetermined_objectives_values.split(""))
       selected_values.push("DepartmentalSdbip.predetermined_objective.name")
     end
     if params[:data_value].include?('Reporting Category')
       #reporting_category_values = params[:reporting_category_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:reporting_category_id => reporting_category_values.split(""))
     end
     if params[:data_value].include?('GFS Classification')
       mscore_classification_values = params[:mscore_classification_values]
       @sdbip_progresses = @sdbip_progresses.where(:mscore_classification_id => mscore_classification_values.split(""))
       selected_values.push("DepartmentalSdbip.mscore_classification.name")
     end

     if params[:data_value].include?('NDP Objectives')
       ndp_objective_values = params[:ndp_objective_values]
       @sdbip_progresses = @sdbip_progresses.where(:ndp_objective_id => ndp_objective_values.split(""))
       selected_values.push("DepartmentalSdbip.ndp_objective.name")
     end
     if params[:data_value].include?('IDP Ref')
       #idp_ref_values = params[:idp_ref_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:idp_ref => idp_ref_values.split(""))
     end
     if params[:data_value].include?('Strategic Objective')
       strategic_objective_values = params[:strategic_objective_values]
       @sdbip_progresses = @sdbip_progresses.where(:strategic_objective_id => strategic_objective_values.split(""))
       selected_values.push("DepartmentalSdbip.strategic_objective.name")
     end
     if params[:data_value].include?('Impact')
       #impact_values = params[:impact_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:impact => impact_values.split(""))
     end
     if params[:data_value].include?('Source of Evidence')
       #source_of_evidence_values = params[:source_of_evidence_values]
     	 #@sdbip_progresses = @sdbip_progresses.where(:source_of_evidence => source_of_evidence_values.split(""))
     end
     if params[:data_value].include?('Unit of Measurement')
       #unit_of_measurement_values = params[:unit_of_measurement_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:unit_of_measurement => unit_of_measurement_values.split(""))
     end
     if params[:data_value].include?('National Outcome')
       national_outcome_values = params[:national_outcome_values]
       @sdbip_progresses = @sdbip_progresses.where(:national_outcome_id => national_outcome_values.split(""))
       selected_values.push("DepartmentalSdbip.national_outcome.name")
     end
     if params[:data_value].include?('Annual Target')
       #annual_target_values = params[:annual_target_values]
     	#@sdbip_progresses = @sdbip_progresses.where(:annual_target => annual_target_values.split(""))
     end
    end
    @departmental_sdbip_progresses = @departmental_sdbip_progresses
    @departmental_sdbips = DepartmentalSdbip.all
    @kpi_not_yet_measured = DepartmentalSdbip.where("performance_standard = ?", "KPI Not Yet Measured")

    @kpi_measured = DepartmentalSdbip.where("performance_standard != ?", "KPI Measured")
    @kpi_not_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Not Met")
    @kpi_almost_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Almost Met")
    @kpi_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Met")
    @kpi_well_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Well Met")
    @kpi_extremely_well_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Extremely Well Met")

    @get_all_kpis = DepartmentalSdbip.all

    @get_performance_standard = DepartmentalSdbip.where("performance_standard = ?", @performance_standard)

    @get_municipal_manager = DepartmentalSdbip.where("department_id = ?", 1)
    @get_financial_services = DepartmentalSdbip.where("department_id = ?", 2)
    @get_community_services = DepartmentalSdbip.where("department_id = ?", 3)
    @get_corporate_services = DepartmentalSdbip.where("department_id = ?", 4)
    @get_technical_services = DepartmentalSdbip.where("department_id = ?", 5)
    @get_planning_and_development = DepartmentalSdbip.where("department_id = ?", 6)

    @get_basic_service_delivery = DepartmentalSdbip.where("kpa_id = ?", 1)
    @get_good_governance = DepartmentalSdbip.where("kpa_id = ?", 2)
    @get_economic_development = DepartmentalSdbip.where("kpa_id = ?", 3)
    @get_financial_viability = DepartmentalSdbip.where("kpa_id = ?", 4)
    @get_municipal_transformation = DepartmentalSdbip.where("kpa_id = ?", 5)

    @kpi_not_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Met'")
    @kpi_well_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Met'")
    @kpi_well_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Met'")
    @kpi_well_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Met'")
    @kpi_well_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Met'")
    @kpi_well_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Met'")
    @kpi_well_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_basic_service_delivery = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_basic_service_delivery = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_basic_service_delivery = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Met'")
    @kpi_well_met_basic_service_delivery  = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_basic_service_delivery= DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Met'")
    @kpi_well_met_good_governance  = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_economic_development = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_economic_development = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_economic_development = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Met'")
    @kpi_well_met_economic_development  = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_economic_development = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Met'")
    @kpi_well_met_financial_viability  = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Met'")
    @kpi_well_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Extremely Well Met'")

    selected_array_of_values = selected_values
    @selected_headers = selected_headings
    @departmental_sdbip_progresses = @sdbip_progresses
     respond_to do |format|
         format.html
         format.csv { send_data @departmental_sdbip_progresses.report_to_csv(params[:data_value],params[:selected_array_of_values]), :type => 'text/csv', :filename => "file_name-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv"}
         format.xls  { send_data @departmental_sdbip_progresses.report_to_csv(params[:data_value],params[:selected_array_of_values],col_sep: "\t"), :type => 'text/xls', :filename => "file_name-#{Time.now.strftime('%d-%m-%y--%H-%M')}.xls" }
         format.pdf do
          pdf = ReportPdf.new(@departmental_sdbips)
          #send_data pdf.render, filename: 'report.pdf', type: 'application/pdf', :layout => 'landscape'
        end

      end

  end

  def show
  	@departmental_sdbips = DepartmentalSdbip.where('department_id = ?' ,params[:id])
    #@subdepartments = @departmental_sdbips(:subdepartment_id).where(department_id: params[:id]).distinct
    @subdepartments = Subdepartment.where(department_id: params[:id])

    #@departmental_sdbips = DepartmentalSdbip.all
    @get_all_kpis = DepartmentalSdbip.all

     @all_peformance_standard_unspecified = DepartmentalSdbip.where("subdepartment_id = 1")
     @all_peformance_standard_municipal_manager_office = DepartmentalSdbip.where("subdepartment_id = 2")
     @all_peformance_standard_internal_audit = DepartmentalSdbip.where("subdepartment_id = 3")
     @all_peformance_standard_performance_management_unit = DepartmentalSdbip.where("subdepartment_id = 4")
     @all_peformance_standard_legal_services = DepartmentalSdbip.where("subdepartment_id = 5")
     @all_peformance_standard_forestry = DepartmentalSdbip.where("subdepartment_id = 6")

        #kpis_Municipal_manager
    @kpi_not_yet_measured_unspecified = DepartmentalSdbip.where("subdepartment_id = 1 AND performance_standard = 'KPI Not Yet Measured'")
    @kpi_not_yet_measured_municipal_manager_office = DepartmentalSdbip.where("subdepartment_id = 2 AND performance_standard = 'KPI Not Yet Measured'")
    @kpi_not_yet_measured_internal_audit = DepartmentalSdbip.where("subdepartment_id = 3 AND performance_standard = 'KPI Not Yet Measured'")
    @kpi_not_yet_measured_performance_management_unit = DepartmentalSdbip.where("subdepartment_id = 4 AND performance_standard = 'KPI Not Yet Measured'")
    @kpi_not_yet_measured_legal_services = DepartmentalSdbip.where("subdepartment_id = 5 AND performance_standard = 'KPI Not Yet Measured'")
    @kpi_not_yet_measured_forestry = DepartmentalSdbip.where("subdepartment_id = 6 AND performance_standard = 'KPI Not Yet Measured'")

    @kpi_not_met_unspecified = @departmental_sdbips.where("subdepartment_id = 1 AND performance_standard = 'KPI Not Met'")
    @kpi_not_met_municipal_manager_office = @departmental_sdbips.where("subdepartment_id = 2 AND performance_standard = 'KPI Not Met'")
    @kpi_not_met_internal_audit = @departmental_sdbips.where("subdepartment_id = 3 AND performance_standard = 'KPI Not Met'")
    @kpi_not_met_performance_management_unit = @departmental_sdbips.where("subdepartment_id = 4 AND performance_standard = 'KPI Not Met'")
    @kpi_not_met_legal_services = @departmental_sdbips.where("subdepartment_id = 5 AND performance_standard = 'KPI Not Met'")
    @kpi_not_met_forestry = @departmental_sdbips.where("subdepartment_id = 6 AND performance_standard = 'KPI Not Met'")

    @kpi_almost_met_unspecified = @departmental_sdbips.where("subdepartment_id = 1 AND performance_standard = 'KPI Almost Met'")
    @kpi_almost_met_municipal_manager_office = @departmental_sdbips.where("subdepartment_id = 2 AND performance_standard = 'KPI Almost Met'")
    @kpi_almost_met_internal_audit = @departmental_sdbips.where("subdepartment_id = 3 AND performance_standard = 'KPI Almost Met'")
    @kpi_almost_met_performance_management_unit = @departmental_sdbips.where("subdepartment_id = 4 AND performance_standard = 'KPI Almost Met'")
    @kpi_almost_met_legal_services = @departmental_sdbips.where("subdepartment_id = 5 AND performance_standard = 'KPI Almost Met'")
    @kpi_almost_met_forestry = @departmental_sdbips.where("subdepartment_id = 6 AND performance_standard = 'KPI Almost Met'")

    @kpi_met_unspecified = @departmental_sdbips.where("subdepartment_id = 1  AND performance_standard = 'KPI Met'")
    @kpi_met_municipal_manager_office = @departmental_sdbips.where("subdepartment_id = 2 AND performance_standard = 'KPI Met'")
    @kpi_met_internal_audit = @departmental_sdbips.where("subdepartment_id = 3 AND performance_standard = 'KPI Met'")
    @kpi_met_performance_management_unit = @departmental_sdbips.where("subdepartment_id = 4 AND performance_standard = 'KPI Met'")
    @kpi_met_legal_services = @departmental_sdbips.where("subdepartment_id = 5 AND performance_standard = 'KPI Met'")
    @kpi_met_forestry = @departmental_sdbips.where("subdepartment_id = 6 AND performance_standard = 'KPI Met'")

    @kpi_well_met_unspecified = @departmental_sdbips.where("subdepartment_id = 1 AND performance_standard = 'KPI Well Met'")
    @kpi_well_met_municipal_manager_office = @departmental_sdbips.where("subdepartment_id = 2 AND performance_standard = 'KPI Well Met'")
    @kpi_well_met_internal_audit = @departmental_sdbips.where("subdepartment_id = 3 AND performance_standard = 'KPI Well Met'")
    @kpi_well_met_performance_management_unit = @departmental_sdbips.where("subdepartment_id = 4 AND performance_standard = 'KPI Well Met'")
    @kpi_well_met_legal_services = @departmental_sdbips.where("subdepartment_id = 5 AND performance_standard = 'KPI Well Met'")
    @kpi_well_met_forestry = @departmental_sdbips.where("subdepartment_id = 6 AND performance_standard = 'KPI Well Met'")

    @kpi_extremely_well_met_unspecified = @departmental_sdbips.where("subdepartment_id = 1 AND performance_standard = 'KPI Extremely Well Met'")
    @kpi_extremely_well_met_municipal_manager_office = @departmental_sdbips.where("subdepartment_id = 2 AND performance_standard = 'KPI Extremely Well Met'")
    @kpi_extremely_well_met_internal_audit = @departmental_sdbips.where("subdepartment_id = 3 AND performance_standard = 'KPI Extremely Well Met'")
    @kpi_extremely_well_met_performance_management_unit = @departmental_sdbips.where("subdepartment_id = 4 AND performance_standard = 'KPI Extremely Well Met'")
    @kpi_extremely_well_met_legal_services = @departmental_sdbips.where("subdepartment_id = 5 AND performance_standard = 'KPI Extremely Well Met'")
    @kpi_extremely_well_met_forestry = @departmental_sdbips.where("subdepartment_id = 6 AND performance_standard = 'KPI Extremely Well Met'")

  end

  def export

 end

  private

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      #redirect_to(root_url) unless
      current_user.admin?
    end
    def kpi_owner_user
      redirect_to(root_url) unless !current_user.role.blank? || current_user.admin?
    end
end
