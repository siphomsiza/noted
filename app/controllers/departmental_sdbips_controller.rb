class DepartmentalSdbipsController < ApplicationController
  #before_filter :authenticate
  before_action :logged_in_user, only: [:index, :restore_kpi, :edit, :update,:show,:audit_performance,:generate_graphs]
  before_action :admin_user,     only: [:new, :restore_kpi, :index,:edit,:update, :destroy,:show]
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
    @departmental_sdbip = DepartmentalSdbip.new
    @departments = Department.includes(:subdepartments)
    @deleted_kpis =  DepartmentalKpi.paginate(page: params[:page],per_page: 10)
    @departmental_sdbips_to_file = DepartmentalSdbip.order(:department_id,:subdepartment_id)
    @subdepartments = Subdepartment.where("department_id = ?", Department.first.id)
    @kpitypes = KpiType.all
    if params[:subdepartment_id]

      if !current_user.role.blank? || current_user.admin?
        if current_user.admin? || current_user.role.audit_log_reporting? || current_user.role.top_layer_administrator? || current_user.role.assurance_provider? || current_user.role.secondary_time_period? || current_user.role.finance_admin?
            @departmental_sdbips = DepartmentalSdbip.search(params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date]).includes(:department,:subdepartment,:kpi_type,:kpi_owner,:mscore_classification,:national_outcome,:strategic_objective,:risk_rating,:kpa,:ndp_objective,:capital_project,:kpi_concept,:area,:ward,:reporting_category,:kpi_calculation_type)
              if !@departmental_sdbips.blank?
               @departmental_sdbips =  @departmental_sdbips.paginate(page: params[:page],per_page: 10)
              end
        elsif current_user.role.kpi_owner? && current_user.departmental_administrator.blank?
            kpi_id = current_user.role.kpi_owner_id
            @departmental_sdbips = DepartmentalSdbip.search_kpi(params[:kpi_id],params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])#.includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)
            if !@departmental_sdbips.blank?
              @departmental_sdbips = @departmental_sdbips.paginate(page: params[:page],per_page: 10)
            end
        elsif !current_user.role.kpi_owner? && !current_user.departmental_administrator.blank?
              department_id = nil
              current_user.departmental_administrator.each do |dept_id|
                department_id = dept_id.department_id
              end
              @departmental_sdbips = DepartmentalSdbip.search_departmental_kpis(params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])#.includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)
              if !@departmental_sdbips.blank?
                @departmental_sdbipsrtmental_sdbips = @departmental_sdbips.paginate(page: params[:page],per_page: 10)
              end
        elsif current_user.role.kpi_owner? && current_user.subdepartmental_administrator.blank?
                kpi_id = current_user.role.kpi_owner_id
                @departmental_sdbips = DepartmentalSdbip.search_subdepartment_kpis(params[:kpi_id],params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])#.includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)
                if !@departmental_sdbips.blank?
                  @departmental_sdbips = @departmental_sdbips.paginate(page: params[:page],per_page: 10)
                end
        elsif !current_user.role.kpi_owner? && !current_user.subdepartmental_administrator.blank?
                    subdepartment_id = nil
                  current_user.role.roles_details.each do |dept_id|
                    subdepartment_id = dept_id.subdepartment_id
                  end
                  @departmental_sdbips = DepartmentalSdbip.search_subdepartment_kpis(params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])#.includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)
                  if !@departmental_sdbips.blank?
                    @departmental_sdbips= @departmental_sdbips.paginate(page: params[:page],per_page: 10)#.includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)
                  end
        else

        end

      end
    elsif !params[:subdepartment_id]

           if !current_user.role.blank? || current_user.admin?

             if current_user.admin? || current_user.role.audit_log_reporting? || current_user.role.top_layer_administrator? || current_user.role.assurance_provider? || current_user.role.secondary_time_period? || current_user.role.finance_admin?
                @departmental_sdbips = DepartmentalSdbip.paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating,:kpi_results,:assurances)

              elsif current_user.role.kpi_owner? && current_user.departmental_administrator.blank?
                kpi_id = current_user.role.kpi_owner_id
                @departmental_sdbips = DepartmentalSdbip.where(kpi_owner_id: kpi_id).paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)

              elsif !current_user.role.kpi_owner? && !current_user.departmental_administrator.blank?
                current_user.departmental_administrator.each do |dept_id|
                  kpi_id = dept_id.department_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(department_id: [kpi_id]).paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)

              elsif current_user.role.kpi_owner? && current_user.subdepartmental_administrator.blank?
                kpi_id = nil
                  kpi_id = current_user.role.kpi_owner_id

                @departmental_sdbips = DepartmentalSdbip.where(kpi_owner_id: kpi_id).paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)

              elsif !current_user.subdepartmental_administrator.blank?
                department_id = nil
                subdepartment_id = nil
                current_user.role.roles_details.each do |dept_id|
                  department_id = dept_id.department_id
                  subdepartment_id = dept_id.subdepartment_id
                end

                @departmental_sdbips = DepartmentalSdbip.where(department_id: department_id).paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)

              elsif !current_user.role.kpi_owner? && !current_user.subdepartmental_administrator.blank?
                kpi_id = nil
                current_user.subdepartmental_administrator.each do |dept_id|
                  kpi_id = dept_id.subdepartment_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(subdepartment_id: kpi_id).paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)

              elsif current_user.role.kpi_owner? && !current_user.subdepartmental_administrator.blank?
                kpi_id = nil
                current_user.subdepartmental_administrator.each do |dept_id|
                  kpi_id = dept_id.subdepartment_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(subdepartment_id: kpi_id).paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)


              elsif current_user.role.kpi_owner? && !current_user.departmental_administrator.blank?
                kpi_id = nil
                current_user.departmental_administrator.each do |dept_id|
                  kpi_id = dept_id.department_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(department_id: kpi_id).paginate(:per_page => 10, :page => params[:page]).includes(:capital_project,:department,:subdepartment,:kpi_type,:kpi_owner,:kpi_concept,:kpi_calculation_type,:mscore_classification,:kpa,:strategic_objective,:national_outcome,:ward,:area,:reporting_category,:ndp_objective,:risk_rating)

              else

              end

            end
    end
    respond_to do |format|

    format.html
    format.csv { send_data @departmental_sdbips_to_file.to_csv }
    format.xls  { send_data @departmental_sdbips_to_file.to_csv(col_sep: "\t") }
    end
end
  def restore_kpi
    @deleted_kpi = DepartmentalKpi.find(params[:id])
    DepartmentalSdbip.create(@deleted_kpi.attributes).save if @deleted_kpi
    @deleted_kpi.destroy
    flash[:success] = "KPI was successfully restored."
    redirect_to departmental_sdbips_path
  end
  def show
    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
  end

  def new
    @departmental_sdbip = DepartmentalSdbip.new
  end

  def create

    @departmental_sdbip = DepartmentalSdbip.new(departmental_sdbip_params)
    if @departmental_sdbip.save
      flash[:success] = "KPI was successfully saved."
      redirect_to departmental_sdbips_path
    else
      flash[:danger] = "KPI was not saved. please fill all the required fields."
      redirect_to departmental_sdbips_path
    end
  end

  def update_subdepartments
    @subdepartments = Subdepartment.where("department_id = ?", params[:department_id])
    respond_to do |format|
      format.js
    end
  end

  def audit_performance
     @departmental_sdbip = DepartmentalSdbip.find(params[:id])
     #@departmental_sdbip.includes(:kpi_results)
     if @departmental_sdbip.assurances.where("extract(month from created_at) = ? AND extract(year from created_at) = ? AND departmental_sdbip_id = ? ",Date.today.month,Date.today.year,@departmental_sdbip.id).any?
     else
       @departmental_sdbip.assurances.build
     end
  end
  def edit
    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
    if @departmental_sdbip.kpi_results.where("extract(month from period) = ? AND extract(year from period) = ? AND departmental_sdbip_id = ? ",Date.today.month,Date.today.year,@departmental_sdbip.id).any?
    else
      @departmental_sdbip.kpi_results.build
    end
  end

  def edit_kpis
    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
  end

  def update
    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
    #@departmental_sdbip.kpi_results.user_id = current_user.id
    #@departmental_sdbip.assurances.user_id = current_user.id

    if @departmental_sdbip.update(departmental_sdbip_params)
        #audit_log(departmental_sdbip_id)
        flash[:success] = "KPI was successfully updated"
        redirect_to :back
    else
      flash[:danger] = "KPI was not updated"
      redirect_to :back
    end
  end
  def import
    if params[:file].nil?
      flash[:danger] = 'You have not selected a file'
      redirect_to departmental_sdbips_path
    else
    begin
      #FileUtils.mv(file_location, '/db/data/')
      #temp = Tempfile.new(params[:file].original_filename)
      #xlsx_package.serialize temp.path
      #send_file temp.path, :filename => params[:file].original_filename, :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
       DepartmentalSdbip.import_from_file(params[:file])
       flash[:success] = "SDBIP submitted successfully for processing."
       redirect_to departmental_sdbips_path
    rescue => e
       flash[:danger] = "SDBIP failed to import #{e.message}."
       Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
       #temp.close
       #temp.unlink
       redirect_to :back
    end
    #redirect_to departmental_sdbips_path
  end

  end
  def destroy
    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
    DepartmentalKpi.create(@departmental_sdbip.attributes).save if @departmental_sdbip
    @departmental_sdbip.destroy
    flash[:success] = "KPI deleted successfully."
    redirect_to departmental_sdbips_path
  end

  private
    def departmental_sdbip_params
        params.require(:departmental_sdbip).permit(:subdepartment_name,:department_name,:kpa_name,:department_id,
          :subdepartment_id, :kpi_ref_number, :mscore_classification_id,:idp_ref, :national_outcome_id, :strategic_objective_id,
          :kpa_id,:kpi_target_type_id,
          :predetermined_objective_id, :ndp_objective_id,
          :capital_project_id, :kpi, :unit_of_measurement,
          :kpi_concept_id, :kpi_type_id, :risk_reg_ref,
          :comments, :risk_rating_id, :ward_id, :area_id,
          :kpi_owner_id, :baseline, :past_year_performance,
          :performance_standard, :proof_of_evidence, :mtas_indicator,
          :reporting_category_id, :provincial_strategic_outcome_id,
          :source_of_evidence, :target, :annual_target,:first_quarter_target,:second_quarter_target,:third_quarter_target,:fourth_quarter_target,:first_quarter_actual,:second_quarter_actual,:third_quarter_actual,:fourth_quarter_actual,:first_quarter_poe,:second_quarter_poe,:third_quarter_poe,:fourth_quarter_poe, :budget, :impact, :top_layer_kpi_ref,
           :kpi_calculation_type_id,
          :kpi_target_type_id, :annual_target, :revised_target, :assurances_attributes=>[:id,:user_id,:signed_off,:response,:kpi_result_id,:poe], :kpi_results_attributes => [:id,:target,:actual,:kpi_performance_standard,:user_id,:performance_comments,:corrective_measures,:_destroy,:period,:attachments_attributes => [ :id,:name,:_destroy]])
    end
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def set_departmental_sdbip
        @departmental_sdbip = DepartmentalSdbip.find(params[:id])
      end
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?# || correct_user?
    end
    def
    def correct_user
       !current_user.role.blank? && (current_user.role.audit_log_reporting? || current_user.role.assurance_provider? || !current_user.kpi_owner.blank? && current_user.role.kpi_owner? || !current_user.departmental_administrator.blank? || !current_user.subdepartmental_administrator.blank? )
    end

end
