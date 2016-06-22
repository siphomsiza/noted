class DepartmentalSdbipProgressesController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:export]
  before_action :admin_user,     only: [:index,:show,:export]
  before_action :kpi_owner_user,     only: [:index,:show,:export]
  skip_before_filter  :verify_authenticity_token

  def index
    selected_values = []
    @departmental_sdbip_progresses = DepartmentalSdbip.all
    csv_string = CSV.generate do |csv|
      #column_names = [params[:data_value]]
      csv << DepartmentalSdbip.column_names
      @departmental_sdbip_progresses.each do |departmental_sdbip|
        #csv << [departmental_sdbip.kpi_ref_number, departmental_sdbip.kpi,departmental_sdbip.department.name, departmental_sdbip.subdepartment.subdepartment_name,departmental_sdbip.kpa.name,departmental_sdbip.kpi_type.name,departmental_sdbip.kpi_owner.name,departmental_sdbip.strategic_objective.name,departmental_sdbip.baseline,departmental_sdbip.annual_target,departmental_sdbip.revised_target,departmental_sdbip.first_quarter_target,departmental_sdbip.second_quarter_target,departmental_sdbip.third_quarter_target,departmental_sdbip.fourth_quarter_target, departmental_sdbip.area.name,departmental_sdbip.ward.name,departmental_sdbip.source_of_evidence,departmental_sdbip.unit_of_measurement]
      end
    end
   if params[:data_value]
     @sdbip_progresses = DepartmentalSdbip.all

     if params[:data_value].include?('Department')
       departments_value = params[:departments_value]
       @sdbip_progresses = @sdbip_progresses.where(:department_id => departments_value.split(""))
       selected_values << "DepartmentalSdbip.department_name"
     end
     if params[:data_value].include?('Sub-Department')
       subdepartments_value = params[:subdepartments_value]
       @sdbip_progresses = @sdbip_progresses.where(:subdepartment_id => subdepartments_value.split(""))
       selected_values << "DepartmentalSdbip.subepartment_name"
     end
     if params[:data_value].include?('KPI Owner')
       @sdbip_progresses = @sdbip_progresses.where(:kpi_owner_id => kpi_owner_values.split(""))
     end
     if params[:data_value].include?('Project Name')
     	@sdbip_progresses = @sdbip_progresses.where(["id = ?",project_name])
     end
     if params[:data_value].include?('KPI Ref Number')
     	@sdbip_progresses = @sdbip_progresses.where(["kpi_ref_number = ?",kpi_ref_number])
     end
     if params[:data_value].include?('Revised Target')
     	@sdbip_progresses = @sdbip_progresses.where(["revised_target = ?",revised_target])
     end
     if params[:data_value].include?('KPI Concept')
       @sdbip_progresses = @sdbip_progresses.where(:kpi_concept_id => kpi_concept_values.split(""))
     end
     if params[:data_value].include?('KPI Type')
       @sdbip_progresses = @sdbip_progresses.where(:kpi_type_id => kpi_type_values.split(""))
     end

     if params[:data_value].include?('KPI Calculation Type')
       @sdbip_progresses = @sdbip_progresses.where(:kpi_calculation_type_id => kpi_calculation_type_values.split(""))
     end

     if params[:data_value].include?('Top Layer KPI Ref')
     	@sdbip_progresses = @sdbip_progresses.where(["top_layer_kpi_ref = ?",top_layer_kpi_ref])
     end
     if params[:data_value].include?('Baseline')
     	@sdbip_progresses = @sdbip_progresses.where(["baseline = ?",baseline])
     end
     if params[:data_value].include?('Wards')
       @sdbip_progresses = @sdbip_progresses.where(:ward_id => ward_values.split(""))
     end
     if params[:data_value].include?('Area')
       @sdbip_progresses = @sdbip_progresses.where(:area_id => area_values.split(""))
     end

     if params[:data_value].include?('Budget')
     	@sdbip_progresses = @sdbip_progresses.where(["budget = ?",budget])
     end
     if params[:data_value].include?('KPI')
       @sdbip_progresses = @sdbip_progresses.where(:kpi => kpi_values.split(""))
     end
     if params[:data_value].include?('KPA')
       @sdbip_progresses = @sdbip_progresses.where(:kpa_id => kpa_values.split(""))
     end
     if params[:data_value].include?('Past Year Performance')
     	@sdbip_progresses = @sdbip_progresses.where(["past_year_performance = ?",past_year_performance])
     end
     if params[:data_value].include?('Provincial Strategic Outcome')
       @sdbip_progresses = @sdbip_progresses.where(:provincial_strategic_outcome_id => provincial_strategic_outcome_values.split(""))
     end
     if params[:data_value].include?('Predetermined Objectives')
       @sdbip_progresses = @sdbip_progresses.where(:predetermined_objective_id => predetermined_objectives_values.split(""))
     end
     if params[:data_value].include?('Reporting Category')
     	@sdbip_progresses = @sdbip_progresses.where(["reporting_category_id = ?",reporting_category_id])
     end
     if params[:data_value].include?('GFS Classification')
       @sdbip_progresses = @sdbip_progresses.where(:mscore_classification_id => mscore_classification_values.split(""))
     end

     if params[:data_value].include?('NDP Objectives')
       @sdbip_progresses = @sdbip_progresses.where(:ndp_objective_id => ndp_objective_values.split(""))
     end
     if params[:data_value].include?('IDP Ref')
     	@sdbip_progresses = @sdbip_progresses.where(["idp_ref = ?",idp_ref])
     end
     if params[:data_value].include?('Strategic Objective')
       @sdbip_progresses = @sdbip_progresses.where(:strategic_objective_id => strategic_objective_values.split(""))
     end
     if params[:data_value].include?('Impact')
     	@sdbip_progresses = @sdbip_progresses.where(["impact = ?",impact])
     end
     if params[:data_value].include?('Source of Evidence')
     	 @sdbip_progresses = @sdbip_progresses.where("source_of_evidence = ?",source_of_evidence)
     end
     if params[:data_value].include?('Unit of Measurement')
     	@sdbip_progresses = @sdbip_progresses.where("unit_of_measurement = ?",unit_of_measurement)
     end
     if params[:data_value].include?('National Outcome')
       @sdbip_progresses = @sdbip_progresses.where(:national_outcome_id => national_outcome_values.split(""))
     end
     if !annual_target.blank?  && annual_target.to_i > 0
     	@sdbip_progresses = @sdbip_progresses.where(["annual_target = ?",annual_target])
     end
     @departmental_sdbip_progresses = @sdbip_progresses

      csv_string = CSV.generate do |csv|
        column_names = [params[:data_value]]
        csv << column_names
        @departmental_sdbip_progresses.each do |departmental_sdbip|
          csv << [departmental_sdbip.kpi_ref_number, departmental_sdbip.kpi,departmental_sdbip.department.name, departmental_sdbip.subdepartment.subdepartment_name,departmental_sdbip.kpa.name,departmental_sdbip.kpi_type.name,departmental_sdbip.kpi_owner.name,departmental_sdbip.strategic_objective.name,departmental_sdbip.baseline,departmental_sdbip.annual_target,departmental_sdbip.revised_target,departmental_sdbip.first_quarter_target,departmental_sdbip.second_quarter_target,departmental_sdbip.third_quarter_target,departmental_sdbip.fourth_quarter_target, departmental_sdbip.area.name,departmental_sdbip.ward.name,departmental_sdbip.source_of_evidence,departmental_sdbip.unit_of_measurement]
        end
      end
      respond_to do |format|
        format.html
        format.csv { send_data(csv_string, :type => 'test/csv', :filename => "sdbips-{Time.now.strftime('%d-%m-%y--%H-%M')}.csv")}#(params[:data_value]),:type=>'csv/text', filename: "sdbips-#{Date.today}.csv" }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
      #send_data(csv_string, :type => 'test/csv', :filename => "sdbips-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv")
      #puts send_data(csv_string, :type => 'test/csv', :filename => "sdbips-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv")
   else
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

    respond_to do |format|
      format.html
      format.csv { send_data(csv_string, :type => 'test/csv', :filename => "sdbips-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv")}#(params[:data_value]),:type=>'csv/text', filename: "sdbips-#{Date.today}.csv" }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = ReportPdf.new(@departmental_sdbips)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf', :layout => 'landscape'
      end
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
    selected_values = []
   if params[:data_value]
     @sdbip_progresses = DepartmentalSdbip.all

     if params[:data_value].include?('Department')
       departments_value = params[:departments_value]
       @sdbip_progresses = @sdbip_progresses.where(:department_id => departments_value.split(""))
       selected_values << "department_name"
     end
     if params[:data_value].include?('Sub-Department')
       subdepartments_value = params[:subdepartments_value]
       @sdbip_progresses = @sdbip_progresses.where(:subdepartment_id => subdepartments_value.split(""))
       selected_values << "subepartment_name"
     end
     #if params[:data_value].include?('KPI Owner')
      # @sdbip_progresses = @sdbip_progresses.where(:kpi_owner_id => kpi_owner_values.split(""))
     #end
     #if params[:data_value].include?('Project Name')
     #	@sdbip_progresses = @sdbip_progresses.where(["id = ?",project_name])
     #end
     #if params[:data_value].include?('KPI Ref Number')
     #	@sdbip_progresses = @sdbip_progresses.where(["kpi_ref_number = ?",kpi_ref_number])
     #end
     #if params[:data_value].include?('Revised Target')
     #	@sdbip_progresses = @sdbip_progresses.where(["revised_target = ?",revised_target])
     #end
     #if params[:data_value].include?('KPI Concept')
    #   @sdbip_progresses = @sdbip_progresses.where(:kpi_concept_id => kpi_concept_values.split(""))
     #end
     #if params[:data_value].include?('KPI Type')
    #   @sdbip_progresses = @sdbip_progresses.where(:kpi_type_id => kpi_type_values.split(""))
     #end
 #
     #if params[:data_value].include?('KPI Calculation Type')
    #   @sdbip_progresses = @sdbip_progresses.where(:kpi_calculation_type_id => kpi_calculation_type_values.split(""))
     #end

     #if params[:data_value].include?('Top Layer KPI Ref')
     #	@sdbip_progresses = @sdbip_progresses.where(["top_layer_kpi_ref = ?",top_layer_kpi_ref])
     #end
     #if params[:data_value].include?('Baseline')
     #	@sdbip_progresses = @sdbip_progresses.where(["baseline = ?",baseline])
     #end
     #if params[:data_value].include?('Wards')
    #   @sdbip_progresses = @sdbip_progresses.where(:ward_id => ward_values.split(""))
     #end
     #if params[:data_value].include?('Area')
    #   @sdbip_progresses = @sdbip_progresses.where(:area_id => area_values.split(""))
     #end
 #
     #if params[:data_value].include?('Budget')
     #	@sdbip_progresses = @sdbip_progresses.where(["budget = ?",budget])
     #end
     #if params[:data_value].include?('KPI')
    #   @sdbip_progresses = @sdbip_progresses.where(:kpi => kpi_values.split(""))
     #end
     #if params[:data_value].include?('KPA')
    #   @sdbip_progresses = @sdbip_progresses.where(:kpa_id => kpa_values.split(""))
     #end
     #if params[:data_value].include?('Past Year Performance')
     #	@sdbip_progresses = @sdbip_progresses.where(["past_year_performance = ?",past_year_performance])
     #end
     #if params[:data_value].include?('Provincial Strategic Outcome')
    #   @sdbip_progresses = @sdbip_progresses.where(:provincial_strategic_outcome_id => provincial_strategic_outcome_values.split(""))
     #end
     #if params[:data_value].include?('Predetermined Objectives')
    #   @sdbip_progresses = @sdbip_progresses.where(:predetermined_objective_id => predetermined_objectives_values.split(""))
     #end
     #if params[:data_value].include?('Reporting Category')
     #	@sdbip_progresses = @sdbip_progresses.where(["reporting_category_id = ?",reporting_category_id])
     #end
     #if params[:data_value].include?('GFS Classification')
    #   @sdbip_progresses = @sdbip_progresses.where(:mscore_classification_id => mscore_classification_values.split(""))
     #end
 #
     #if params[:data_value].include?('NDP Objectives')
    #   @sdbip_progresses = @sdbip_progresses.where(:ndp_objective_id => ndp_objective_values.split(""))
     #end
     #if params[:data_value].include?('IDP Ref')
     #	@sdbip_progresses = @sdbip_progresses.where(["idp_ref = ?",idp_ref])
     #end
     #if params[:data_value].include?('Strategic Objective')
    #   @sdbip_progresses = @sdbip_progresses.where(:strategic_objective_id => strategic_objective_values.split(""))
     #end
     #if params[:data_value].include?('Impact')
     #	@sdbip_progresses = @sdbip_progresses.where(["impact = ?",impact])
     #end
     #if params[:data_value].include?('Source of Evidence')
     #	@sdbip_progresses = @sdbip_progresses.where(["source_of_evidence = ?",source_of_evidence])
     #end
     #if params[:data_value].include?('Unit of Measurement')
     #	@sdbip_progresses = @sdbip_progresses.where(["unit_of_measurement = ?",unit_of_measurement])
     #end
     #if params[:data_value].include?('National Outcome')
    #   @sdbip_progresses = @sdbip_progresses.where(:national_outcome_id => national_outcome_values.split(""))
     #end
     #if !annual_target.blank?  && annual_target.to_i > 0
     #	@sdbip_progresses = @sdbip_progresses.where(["annual_target = ?",annual_target])
     #end
     @departmental_sdbip_progresses = @sdbip_progresses

      csv_string = CSV.generate do |csv|
        column_names = [params[:data_value]]
        csv << column_names
        #all.each do |departmental_sdbip|
          #csv << [departmental_sdbip.kpi_ref_number, departmental_sdbip.kpi,departmental_sdbip.department.name, departmental_sdbip.subdepartment.subdepartment_name,departmental_sdbip.kpa.name,departmental_sdbip.kpi_type.name,departmental_sdbip.kpi_owner.name,departmental_sdbip.strategic_objective.name,departmental_sdbip.baseline,departmental_sdbip.annual_target,departmental_sdbip.revised_target,departmental_sdbip.first_quarter_target,departmental_sdbip.second_quarter_target,departmental_sdbip.third_quarter_target,departmental_sdbip.fourth_quarter_target, departmental_sdbip.area.name,departmental_sdbip.ward.name,departmental_sdbip.source_of_evidence,departmental_sdbip.unit_of_measurement]
        #end
      end

      send_data(csv_string, :type => 'test/csv', :filename => "sdbips-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv")
      #puts send_data(csv_string, :type => 'test/csv', :filename => "sdbips-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv")
   end

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
