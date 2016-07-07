class DepartmentalSdbipProgressesController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:export]
  before_action :admin_user,     only: [:index,:show,:export]
  before_action :kpi_owner_user,     only: [:index,:show,:export]
  skip_before_filter  :verify_authenticity_token

  def index

    selected_values = []
    selected_headings = []
    if params[:selected_columns] && (params[:department_id] || params[:department_id] || params[:subdepartment_id] || params[:kpi_ref_number] || params[:predetermined_objective_id] || params[:kpi_owner_id] || params[:kpi] || params[:unit_of_measurement] || params[:mcore_classification_id] || params[:strategic_objective_id] || params[:source_of_evidence] || params[:baseline] || params[:annual_target] || params[:revised_target] || params[:national_kpa_id] || params[:ndp_objective_id] || params[:kpi_concept_id] || params[:kpi_type_id] || params[:provincial_strategic_outcome_id] || params[:ward_id] || params[:area_id] || params[:performance_standard] || params[:kpi_calculation_type_id] || params[:kpi_target_type_id])
      selected_audit_headers = params[:selected_columns]
      $selected_audit_headers = params[:selected_columns]
      @selected_audit_headers = params[:selected_columns]
      @audit_logs = Activity.all
      @audit_logs = Activity.filter_audit_logs(params[:top_layer_kpi_ref_filters],params[:capital_project_filters],params[:selected_columns],params[:department_id],
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
      params[:kpi_target_type_id],params[:past_year_performance],
      params[:impact])

        @audit_logs = @audit_logs
        @audit_values = @audit_columns

    end

   if params[:data_value] && (params[:department_id] || params[:department_id] || params[:subdepartment_id] || params[:kpi_ref_number] || params[:predetermined_objective_id] || params[:kpi_owner_id] || params[:kpi] || params[:unit_of_measurement] || params[:mcore_classification_id] || params[:strategic_objective_id] || params[:source_of_evidence] || params[:baseline] || params[:annual_target] || params[:revised_target] || params[:national_kpa_id] || params[:ndp_objective_id] || params[:kpi_concept_id] || params[:kpi_type_id] || params[:provincial_strategic_outcome_id] || params[:ward_id] || params[:area_id] || params[:performance_standard] || params[:kpi_calculation_type_id] || params[:kpi_target_type_id])
     selected_audit_headers = params[:data_value]
     $selected_audit_headers = params[:data_value]
     @selected_audit_headers = params[:data_value]
     @audit_logs = DepartmentalSdbip.all
     @audit_logs = DepartmentalSdbip.filter_sdbip_report(params[:sdbip_top_layer_kpi_ref_filters],params[:sdbip_capital_project_filters],params[:data_value],params[:department_id],
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
     params[:kpi_target_type_id],params[:past_year_performance],
     params[:impact])

       @audit_logs = @audit_logs
       @audit_values = @audit_columns

    end

    if !@audit_logs.blank?
        @audit_logs = @audit_logs
    end
     @selected_audit_headers = selected_audit_headers
     audit_array_of_values = $audit_values

     ####Graphs###
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
         format.csv { send_data @audit_logs.report_to_csv , :type => 'text/csv', :filename => "#{params[:file_name]}-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv" }
         format.xls  { send_data @audit_logs.report_to_csv(col_sep: "\t"), :type => 'text/xls', :filename => "#{params[:file_name]}-#{Time.now.strftime('%d-%m-%y--%H-%M')}.xls"  }
         format.pdf do
          pdf = ReportPdf.new(@departmental_sdbips)
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
