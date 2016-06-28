class DepartmentalSdbipsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update,:show]
  before_action :admin_user,     only: [:new, :index, :destroy,:show]
  before_action :kpi_owner_user,     only: [:index,:edit,:update, :index,:show]
  def index

    @departmental_sdbip = DepartmentalSdbip.new
    @departments = Department.all
    @capital_projects = CapitalProject.paginate(page: params[:page],per_page: 10)
    @departmental_sdbips_to_file = DepartmentalSdbip.order(:department_id,:subdepartment_id)
    @subdepartments = Subdepartment.where("department_id = ?", Department.first.id)
    @kpitypes = KpiType.all
    if params[:subdepartment_id]

      if !current_user.role.blank? || current_user.admin?
        if current_user.admin? || current_user.role.auditor_general? || current_user.role.internal_auditor? || current_user.role.municipal_manager?
            @departmental_sdbips = DepartmentalSdbip.search(params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])
              if !@departmental_sdbips.blank?
               @departmental_sdbips =  @departmental_sdbips.paginate(page: params[:page],per_page: 10)
              end
        elsif current_user.role.kpi_owner? && !current_user.role.departmental_administrator?
            kpi_id = current_user.role.kpi_owner_id
            @departmental_sdbips = DepartmentalSdbip.search_kpi(params[:kpi_id],params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])
            if !@departmental_sdbips.blank?
              @departmental_sdbips = @departmental_sdbips.paginate(page: params[:page],per_page: 10)
            end
        elsif !current_user.role.kpi_owner? && current_user.role.departmental_administrator?
              department_id = nil
              current_user.role.roles_details.each do |dept_id|
                department_id = dept_id.department_id
              end
              @departmental_sdbips = DepartmentalSdbip.search_departmental_kpis(params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])
              if !@departmental_sdbips.blank?
                @departmental_sdbipsrtmental_sdbips = @departmental_sdbips.paginate(page: params[:page],per_page: 10)
              end
        elsif current_user.role.kpi_owner? && !current_user.role.subdepartmental_administrator?
                kpi_id = current_user.role.kpi_owner_id
                @departmental_sdbips = DepartmentalSdbip.search_subdepartment_kpis(params[:kpi_id],params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])
                if !@departmental_sdbips.blank?
                  @departmental_sdbips = @departmental_sdbips.paginate(page: params[:page],per_page: 10)
                end
        elsif !current_user.role.kpi_owner? && current_user.role.subdepartmental_administrator?
                    subdepartment_id = nil
                  current_user.role.roles_details.each do |dept_id|
                    subdepartment_id = dept_id.subdepartment_id
                  end
                  @departmental_sdbips = DepartmentalSdbip.search_subdepartment_kpis(params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])
                  if !@departmental_sdbips.blank?
                    @departmental_sdbips= @departmental_sdbips.paginate(page: params[:page],per_page: 10)
                  end

        elsif current_user.role.kpi_owner? && current_user.role.departmental_administrator?
                kpi_id = current_user.role.kpi_owner_id
                @departmental_sdbips = DepartmentalSdbip.search_kpi(params[:kpi_id],params[:department_id],params[:subdepartment_id],params[:kpi_type_id],params[:start_date],params[:end_date])
                if !@departmental_sdbips.blank?
                 @departmental_sdbips= @departmental_sdbips.paginate(page: params[:page],per_page: 10)
                end

        else

        end

      end
    elsif !params[:subdepartment_id]

           if !current_user.role.blank? || current_user.admin?

             if current_user.admin? || current_user.role.auditor_general? || current_user.role.internal_auditor? || current_user.role.municipal_manager?
                @departmental_sdbips = DepartmentalSdbip.paginate(:per_page => 10, :page => params[:page])

              elsif current_user.role.kpi_owner? && !current_user.role.departmental_administrator?
                kpi_id = current_user.role.kpi_owner_id
                @departmental_sdbips = DepartmentalSdbip.where(kpi_owner_id: kpi_id).paginate(:per_page => 10, :page => params[:page])

              elsif !current_user.role.kpi_owner? && current_user.role.departmental_administrator?
                current_user.role.roles_details.each do |dept_id|
                  kpi_id = dept_id.department_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(department_id: [kpi_id]).paginate(:per_page => 10, :page => params[:page])

              elsif current_user.role.kpi_owner? && !current_user.role.subdepartmental_administrator?
                kpi_id = nil
                  kpi_id = current_user.role.kpi_owner_id

                @departmental_sdbips = DepartmentalSdbip.where(kpi_owner_id: kpi_id).paginate(:per_page => 10, :page => params[:page])

              elsif current_user.role.departmental_administrator? && current_user.role.subdepartmental_administrator?
                department_id = nil
                subdepartment_id = nil
                current_user.role.roles_details.each do |dept_id|
                  department_id = dept_id.department_id
                  subdepartment_id = dept_id.subdepartment_id
                end

                @departmental_sdbips = DepartmentalSdbip.where(department_id: department_id).paginate(:per_page => 10, :page => params[:page])

              elsif !current_user.role.kpi_owner? && current_user.role.subdepartmental_administrator?
                kpi_id = nil
                current_user.role.roles_details.each do |dept_id|
                  kpi_id = dept_id.subdepartment_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(subdepartment_id: kpi_id).paginate(:per_page => 10, :page => params[:page])

              elsif current_user.role.kpi_owner? && current_user.role.subdepartmental_administrator?
                kpi_id = nil
                current_user.role.roles_details.each do |dept_id|
                  kpi_id = dept_id.subdepartment_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(subdepartment_id: kpi_id).paginate(:per_page => 10, :page => params[:page])


              elsif current_user.role.kpi_owner? && current_user.role.departmental_administrator?
                kpi_id = nil
                current_user.role.roles_details.each do |dept_id|
                  kpi_id = dept_id.department_id
                end
                @departmental_sdbips = DepartmentalSdbip.where(department_id: kpi_id).paginate(:per_page => 10, :page => params[:page])

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

  def edit
    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
  end

  def update

    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
    if @departmental_sdbip.update_attributes(departmental_sdbip_params)
        flash[:success] = "KPI was successfully updated"
        redirect_to departmental_sdbips_path
    else

    end
  end
  def import
    if params[:file].nil?
      redirect_to departmental_sdbips_path, :flash => { :danger => 'You have not selected a file'}
    else
    begin
       DepartmentalSdbip.import(params[:file])
       flash[:success] = "SDBIP imported successfully."
       redirect_to departmental_sdbips_path
    rescue
      flash[:danger] = "SDBIP failed to import."
       redirect_to departmental_sdbips_path
    end
  end
  end
  def destroy
    @departmental_sdbip = DepartmentalSdbip.find(params[:id])
    @departmental_sdbip.destroy
    flash[:success] = "KPI deleted successfully."
    redirect_to departmental_sdbips_path
  end

  private
    def departmental_sdbip_params
        params.require(:departmental_sdbip).permit(:subdepartment_name,:department_name,:kpa_name,:department_id,
          :subdepartment_id, :kpi_ref_number, :mscore_classification_id,:idp_ref, :national_outcome_id, :strategic_objective_id,
          :kpa_id,
          :predetermined_objective_id, :ndp_objective_id,
          :capital_project_id, :kpi, :unit_of_measurement,
          :kpi_concept_id, :kpi_type_id, :risk_reg_ref,
          :comments, :risk_rating_id, :ward_id, :area_id,
          :kpi_owner_id, :baseline, :past_year_performance,
          :performance_standard, :proof_of_evidence, :mtas_indicator,
          :reporting_category_id, :provincial_strategic_outcome_id,
          :source_of_evidence, :annual_target,:first_quarter_target,:second_quarter_target,:third_quarter_target,:fourth_quarter_target,:first_quarter_actual,:second_quarter_actual,:third_quarter_actual,:fourth_quarter_actual,:first_quarter_poe,:second_quarter_poe,:third_quarter_poe,:fourth_quarter_poe, :budget, :impact, :top_layer_kpi_ref,
           :kpi_calculation_type_id,
          :kpi_target_type_id, :annual_target, :revised_target,:start_date,:end_date)
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
      #redirect_to(root_url) unless
      current_user.admin?
    end
    def kpi_owner_user
      redirect_to(root_url) unless !current_user.role.blank? || current_user.admin?
    end

end
