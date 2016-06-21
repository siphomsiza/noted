class DepartmentalSdbipProgressesController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :edit, :update, :destroy,:show,:export]
  before_action :admin_user,     only: [:new, :index, :destroy,:show,:export]
  before_action :kpi_owner_user,     only: [:index,:edit,:update, :index,:show,:export]
  skip_before_filter  :verify_authenticity_token

  def index

     if params[:department_id] || params[:subdepartment_id] || params[:project_name] ||
        params[:predetermined_objective_id]  || params[:kpi_owner_id] || params[:kpi_calculation_type_id] ||
        params[:kpi_concept_id] || params[:national_outcome_id] || params[:revised_target] ||
        params[:kpi_type_id] || params[:impact] || params[:idp_ref] || params[:target] ||
        params[:annual_target] || params[:strategic_objective_id] || params[:budget] ||
        params[:capital_project_id] || params[:kpi_concept_id] || params[:provincial_strategic_outcome_id] ||
        params[:reporting_category_id] || params[:ndp_objective_id] ||
        params[:idp_objective_id] || params[:baseline] || params[:ward_id] ||
        params[:kpi_calculation_type_id] || params[:past_year_performance] || params[:top_layer_kpi_ref]  || params[:area_id]  ||
        params[:national_kpa_id] || params[:source_of_evidence]  || params[:mscore_classification_id]  || params[:unit_of_measurement] || params[:kpi_owner_id] || params[:kpi]

        @departmental_sdbip_progresses = DepartmentalSdbip.generate_report(params[:department_id],params[:subdepartment_id],params[:kpi_owner_id],params[:project_name],params[:kpi_concept_id],params[:kpi_type_id],params[:kpi_calculation_type_id],params[:top_layer_kpi_ref],params[:baseline],params[:target],params[:ward_id],params[:area_id],params[:project_name],params[:capital_project_id],params[:actual],params[:budget],params[:kpi],params[:kpa_id],params[:past_year_performance],params[:provincial_strategic_outcome_id],params[:predetermined_objective_id],params[:reporting_category_id],params[:mscore_classification_id],params[:idp_objective_id],params[:ndp_objective_id],params[:idp_ref],params[:strategic_objective_id],params[:impact],params[:source_of_evidence],params[:unit_of_measurement],params[:national_outcome_id],params[:annual_target])

            if !@departmental_sdbip_progresses.blank?
                @departmental_sdbip_progresses.paginate(page: params[:page],per_page: 20)
            end
       @departmental_sdbips = DepartmentalSdbip.all

     elsif !params[:department_id] && !params[:subdepartment_name] && !params[:kpi] && !params[:predetermined_objective_id]

       @departmental_sdbips = DepartmentalSdbip.all
       @departmental_sdbip_progresses = DepartmentalSdbip.all
       @reports = DepartmentalSdbip.paginate( page: params[:page],per_page: 20)
       @charts = DepartmentalSdbip.paginate( page: params[:page],per_page: 20)

    end
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
      format.pdf do
        pdf = ReportPdf.new(@departmental_sdbips)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf', :layout => 'landscape'
      end
    end

  end




def export_sdbip_report
@sdbip_report = DepartmentalSdbip.includes(:departmental_sdbips)
sdbip_report_csv = CSV.generate do |csv|
csv<<["id"]
@sdbip_report.each do |sdbip_report|
CSV<<[column_values]

end

end

send_data(sdbip_report_csv,:type=>'csv/text',:filename=>text.csv)

end

  def new

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

  def edit

  end
    def create
    @departmental_sdbip_progress = DepartmentalSdbipProgress.new(sdbip_params)
    if @departmental_sdbip_progress.save
      flash[:notice] = "Survey complete! Thank you for your time."
      redirect_to departmental_sdbip_progresses_path
    else
      render :new
    end
  end

  def destroy
    @departmental_sdbip_progress = DepartmentalSdbipProgress.find(params[:id])
    @departmental_sdbip_progress.destroy
    flash[:notice] = "?? was successfully destroyed."
    redirect_to departmental_sdbip_progresses_path
  end

  def update

  end

  def export

   if params[:data_value]
       @departmental_sdbip_progresses = DepartmentalSdbip.filter_report(params[:data_value],params[:departments_value],params[:subdepartments_value],params[:kpi_owner_values],params[:predetermined_objectives_values],params[:kpi_concept_values],params[:kpi_type_values],params[:kpi_calculation_type_values],params[:ward_values],params[:area_values],params[:kpi_values],params[:kpa_values],params[:predetermined_objectives_values],params[:mscore_classification_values],
       params[:ndp_objective_values],params[:strategic_objective_values],params[:national_outcome_values])#params[:department_id],params[:subdepartment_id],params[:kpi_owner_id],params[:project_name],params[:kpi_concept_id],params[:kpi_type_id],params[:kpi_calculation_type_id],params[:top_layer_kpi_ref],params[:baseline],params[:target],params[:ward_id],params[:area_id],params[:project_name],params[:capital_project_id],params[:actual],params[:budget],params[:kpi],params[:kpa_id],params[:past_year_performance],params[:provincial_strategic_outcome_id],params[:predetermined_objective_id],params[:reporting_category_id],params[:mscore_classification_id],params[:idp_objective_id],params[:ndp_objective_id],params[:idp_ref],params[:strategic_objective_id],params[:impact],params[:source_of_evidence],params[:unit_of_measurement],params[:national_outcome_id],params[:annual_target])
       @departmental_sdbip_progresses.each do |sdbip|
         puts sdbip.kpi + "" + sdbip.department.name
       end
      respond_to do |format|
          format.html
          format.csv { send_data @departmental_sdbip_progresses.report_to_csv(params[:data_value]),:type=>'csv/text', filename: "sdbips-#{Date.today}.csv" }
          #format.xls # { send_data @products.to_csv(col_sep: "\t") }
        end

    else

   end

   #redirect_to departmental_sdbips_url

 end


  private
  def sdbip_params
  	params.require(:progress).permit(:sdbip_time_period_id, :actual,
            :poe, :corrective_measures, :comments, :id,:_destroy)
  end
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
