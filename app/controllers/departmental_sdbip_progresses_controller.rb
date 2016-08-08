class DepartmentalSdbipProgressesController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:export]
  before_action :admin_user,     only: [:index,:show,:export]
  before_action :kpi_owner_user,     only: [:index,:show,:export]
  skip_before_filter  :verify_authenticity_token

  def index
    begin

        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
      #@response = @client.fetch_by_location('New York')
      #@response.units.temperature
      #@response.condition.temp

  rescue SignalException => e
    flash[:notice] = "received Exception #{e.message}"
    puts "received Exception #{e}"
  end
      selected_values = []
    selected_headings = []
    if params[:selected_project_columns] && (params[:department_id] || params[:subdepartment_id])
        selected_audit_headers = params[:selected_project_columns]
        $selected_audit_headers = params[:selected_project_columns]
        @selected_audit_headers = params[:selected_project_columns]
        @audit_logs = CapitalProject.all
        @audit_logs = CapitalProject.generate_report(params[:selected_project_columns],
          params[:department_id],params[:subdepartment_id],
          params[:idp_number],params[:vote_number],
          params[:project_name],params[:project_description],
          params[:mscore_classification_id],params[:planned_start_date],
          params[:planned_completion_date],params[:funding_source],
          params[:ward_id],
          params[:area_id],params[:mun_cp_ref],params[:actual_start_date],
          params[:actual_completion_date])
    end
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

    @departmental_sdbips = DepartmentalSdbip.order(performance_standard: :asc).includes(:kpi_results)
    @departments_sdibps = @departmental_sdbips.select(:performance_standard).uniq
    @departmental_sdbips = @departmental_sdbips.paginate(page: params[:page],per_page: 10)
    $colors = []
    @departments_sdibps.each do |color|
    if color.performance_standard.include?("KPI Almost Met")
      $colors.push("orange")
    end
    if color.performance_standard.include?("KPI Extremely Well Met")
      $colors.push("darkblue")
    end
    if color.performance_standard.include?("KPI Met")
      $colors.push("limegreen")
    end
    if color.performance_standard.include?("KPI Not Met")
      $colors.push("red")
    end
    if color.performance_standard.include?("KPI Not Yet Measured")
      $colors.push("#F4C2C2")
    end
    if color.performance_standard.include?("KPI Well Met")
      $colors.push("darkgreen")
    end
  end
    @colours = $colors
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
  def generate_graphs

      @graph_value = params[:data_value].to_i
      @include_sub_graphs = params[:include_sub_graph]
      if !params[:data_value].blank? && params[:data_value].to_i == 0
        @departmental_sdbips = DepartmentalSdbip.all
        @departmental_sdbips_kpa = @departmental_sdbips
        @departments = Department.includes(:departmental_sdbips)
      end

      if !params[:data_value].blank? && params[:data_value].to_i > 0
          @department = Department.includes(:subdepartments,:departmental_sdbips).find(params[:data_value].to_i)
          @departmental_sdbips = DepartmentalSdbip.where(department_id: params[:data_value])
      end

    if !@departmental_sdbips.blank?
      @departmental_sdbips = @departmental_sdbips.order(performance_standard: :asc)
      $colors = []
      @sdbips_chart_theme = @departmental_sdbips.select(:performance_standard).uniq
      @sdbips_chart_theme#.order(performance_standard: :asc)
      @sdbips_chart_theme.each do |color|
      if color.performance_standard.include?("KPI Almost Met")
        $colors.push("orange")
      end
      if color.performance_standard.include?("KPI Extremely Well Met")
        $colors.push("darkblue")
      end
      if color.performance_standard.include?("KPI Met")
        $colors.push("limegreen")
      end
      if color.performance_standard.include?("KPI Not Met")
        $colors.push("red")
      end
      if color.performance_standard.include?("KPI Not Yet Measured")
        $colors.push("#F4C2C2")
      end
      if color.performance_standard.include?("KPI Well Met")
        $colors.push("darkgreen")
      end
    end
  end
      @colours = $colors

  end
  def show

    @departmental_sdbips = DepartmentalSdbip.where(department_id: params[:id]).order(performance_standard: :asc)
    @departments_sdibps = @departmental_sdbips.select(:performance_standard).order(performance_standard: :asc).uniq
    @department = Department.includes(:departmental_sdbips).find(params[:id])

    $colors = []
    @departments_sdibps.each do |color|
    if color.performance_standard.include?("KPI Almost Met")
      $colors.push("orange")
    end
    if color.performance_standard.include?("KPI Extremely Well Met")
      $colors.push("darkblue")
    end
    if color.performance_standard.include?("KPI Met")
      $colors.push("limegreen")
    end
    if color.performance_standard.include?("KPI Not Met")
      $colors.push("red")
    end
    if color.performance_standard.include?("KPI Not Yet Measured")
      $colors.push("#F4C2C2")
    end
    if color.performance_standard.include?("KPI Well Met")
      $colors.push("darkgreen")
    end
  end
    @colours = $colors

  end

  def new

  end
  def edit

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
