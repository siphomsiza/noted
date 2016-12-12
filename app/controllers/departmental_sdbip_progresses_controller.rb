class DepartmentalSdbipProgressesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :export]
  before_action :admin_user,     only: [:index, :show, :export]
  before_action :kpi_owner_user, only: [:index, :show, :export]
  skip_before_filter :verify_authenticity_token

  def index
    weather_details
    selected_headings = []
    if params[:data_value] && !params[:data_value].blank? && (params[:start_date] || params[:end_date] || params[:department_id] || params[:department_id] || params[:subdepartment_id] || params[:kpi_ref_number] || params[:predetermined_objective_id] || params[:kpi_owner_id] || params[:kpi] || params[:unit_of_measurement] || params[:mcore_classification_id] || params[:strategic_objective_id] || params[:source_of_evidence] || params[:baseline] || params[:annual_target] || params[:revised_target] || params[:national_kpa_id] || params[:ndp_objective_id] || params[:kpi_concept_id] || params[:kpi_type_id] || params[:provincial_strategic_outcome_id] || params[:ward_id] || params[:area_id] || params[:performance_standard] || params[:kpi_calculation_type_id] || params[:kpi_target_type_id])
      selected_audit_headers = params[:data_value]
      $selected_audit_headers = params[:data_value]
      @selected_audit_headers = params[:data_value]
      @audit_logs = DepartmentalSdbip.all
      @audit_logs = DepartmentalSdbip.filter_sdbip_report(params[:sdbip_top_layer_kpi_ref_filters], params[:sdbip_capital_project_filters], params[:data_value], params[:department_id],
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
                                                          params[:ward_id], params[:area_id],
                                                          params[:performance_standard],
                                                          params[:kpi_calculation_type_id],
                                                          params[:kpi_target_type_id], params[:past_year_performance],
                                                          params[:impact],
                                                          params[:start_date],
                                                          params[:end_date])
      @audit_logs = @audit_logs
      @audit_values = @audit_columns
    end
    if params[:selected_columns] && !params[:selected_columns].blank? && (params[:start_date] || params[:end_date] || params[:department_id] || params[:department_id] || params[:subdepartment_id] || params[:kpi_ref_number] || params[:predetermined_objective_id] || params[:kpi_owner_id] || params[:kpi] || params[:unit_of_measurement] || params[:mcore_classification_id] || params[:strategic_objective_id] || params[:source_of_evidence] || params[:baseline] || params[:annual_target] || params[:revised_target] || params[:national_kpa_id] || params[:ndp_objective_id] || params[:kpi_concept_id] || params[:kpi_type_id] || params[:provincial_strategic_outcome_id] || params[:ward_id] || params[:area_id] || params[:performance_standard] || params[:kpi_calculation_type_id] || params[:kpi_target_type_id])
      selected_audit_headers = params[:selected_columns]
      $selected_audit_headers = params[:selected_columns]
      @selected_audit_headers = params[:selected_columns]
      @audit_logs = DepartmentalSdbip.all
      @audit_logs = DepartmentalSdbip.filter_audit_logs(params[:top_layer_kpi_ref_filters], params[:capital_project_filters], params[:selected_columns], params[:department_id],
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
                                                        params[:ward_id], params[:area_id],
                                                        params[:performance_standard],
                                                        params[:kpi_calculation_type_id],
                                                        params[:kpi_target_type_id], params[:past_year_performance],
                                                        params[:impact],
                                                        params[:start_date],
                                                        params[:end_date])
      @audit_logs = @audit_logs
      @audit_values = @audit_columns

    end
    @audit_logs = @audit_logs
    @selected_audit_headers = selected_audit_headers
    # ###Graphs###
    @departmental_sdbip_progresses = @departmental_sdbip_progresses
    @periods = KpiResult.select(:period).distinct.limit(1)
    @departmental_sdbips = DepartmentalSdbip.order(performance_standard: :asc).includes(:kpi_results)
    @departments_sdibps = @departmental_sdbips.select(:performance_standard).uniq
    @departmental_sdbips = @departmental_sdbips.paginate(page: params[:page], per_page: 15).order(id: :asc)
    $colors = DepartmentalSdbip.chart_theme @departments_sdibps
    @colours = $colors
    @selected_headers = $selected_array_of_headers
    @records = $selected_array_of_values
    @period_headers = $period_headers
    @departmental_sdbip_progresses = @sdbip_progresses
    #Reports
    @report_departments = DepartmentalSdbip.selected_departments(params[:department_id]) unless params[:department_id].blank?
    @report_kpi_results = DepartmentalSdbip.selected_kpi_results(params[:start_date],params[:end_date]) unless params[:start_date].blank? && params[:end_date].blank?
    @report_departmental_sdbips = @audit_logs.order(id: :asc) unless @audit_logs.blank?
    respond_to do |format|
      format.html
      format.csv { send_data @audit_logs.report_to_csv, type: 'text/csv', filename: "#{params[:file_name]}-#{Time.now.strftime('%d-%B-%Y--%H-%M')}.csv" }
      format.xls do
        response.headers['Content-Disposition'] = "attachment; filename ='#{params[:file_name]} #{Time.now.strftime("%d %B %Y %H:%M")}.xls"
      end # { send_data @audit_logs.report_to_csv(col_sep: "\t"), type: 'text/xls', filename: "#{params[:file_name]}-#{Time.now.strftime('%d-%B-%Y--%H-%M')}.xls" }
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename ='#{params[:file_name]} #{Time.now.strftime("%d %B %Y %H:%M")}.xlsx"
      end
    end
  end

  def assurance_results
    @assurance = Assurance.find(params[:id])
  end

  def generate_graphs
    @graph_value = params[:data_value].to_i
    @include_sub_graphs = params[:include_sub_graph]
    if !params[:data_value].blank? && params[:data_value].to_i == 0
      @departmental_sdbips = DepartmentalSdbip.all.order(performance_standard: :asc)
      @departments = Department.includes(:departmental_sdbips)
    end
    if !params[:data_value].blank? && params[:data_value].to_i > 0
      @department = Department.includes(:subdepartments, :departmental_sdbips).find(params[:data_value].to_i)
      @departmental_sdbips = DepartmentalSdbip.where(department_id: params[:data_value]).order(performance_standard: :asc)
    end
    @departments_sdibps = @departmental_sdbips.select(:performance_standard).uniq.order(performance_standard: :asc)
    $colors = []
    $colors = DepartmentalSdbip.chart_theme @departments_sdibps
    puts $colors.inspect
    @colours = $colors
  end

  def show
    @departmental_sdbips = DepartmentalSdbip.where(department_id: params[:id]).order(performance_standard: :asc)
    @departments_sdibps = @departmental_sdbips.select(:performance_standard).order(performance_standard: :asc).uniq
    @department = Department.includes(:departmental_sdbips).find(params[:id])
    $colors = []
    $colors = DepartmentalSdbip.chart_theme @departments_sdibps
    @colours = $colors
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Confirms an admin user.
  def admin_user
    # redirect_to(root_url) unless
    current_user.admin?
  end

  def kpi_owner_user
    redirect_to(root_url) unless !current_user.role.blank? || current_user.admin? || current_user.super_admin?
  end
end
