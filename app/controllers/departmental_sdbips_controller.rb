class DepartmentalSdbipsController < ApplicationController
    # before_filter :authenticate
    before_action :logged_in_user, only: [:edit_kpis, :index, :restore_kpi, :edit, :update, :show, :audit_performance]
    before_action :set_departmental_sdbip, only: [:edit,:edit_kpis,:update,:show]
    before_action :admin_user, only: [:edit_kpis, :new, :restore_kpi, :index, :edit, :update, :destroy, :show]
    before_action :correct_user, only: [:edit_kpis, :index, :restore_kpi, :edit, :update, :show, :audit_performance]
    def index
      begin
          @client = YahooWeather::Client.new
          @response = @client.fetch(1_582_504)
          @doc = @response.doc
          @forecast = @doc['item']['forecast']
      rescue SocketError => e
          flash[:danger] = "received Exception #{e.message}"
      end
        @departmental_sdbip = DepartmentalSdbip.new
        @departments = Department.includes(:subdepartments)
        @deleted_kpis = DepartmentalKpi.paginate(page: params[:page], per_page: 15)
        @departmental_sdbips_to_file = DepartmentalSdbip.order(:department_id, :subdepartment_id)
        @kpi_types = KpiType.all
        if params[:subdepartment_id] && (!current_user.role.blank? || current_user.admin? || current_user.super_admin?)
                    @periods = KpiResult.select(:period).where("extract(month from period) >= ? AND extract(year from period) >= ? AND extract(month from period) <= ? AND extract(year from period) <= ?" ,params[:start_date].to_date.month,params[:start_date].to_date.year, params[:end_date].to_date.month,params[:end_date].to_date.year).distinct
                    @departmental_sdbips = DepartmentalSdbip.search(params[:subdepartment_id], params[:kpi_type_id], params[:start_date], params[:end_date])
                if current_user.admin? || current_user.super_admin? || current_user.role.audit_log_reporting? || current_user.role.top_layer_administrator? || current_user.role.assurance_provider? || current_user.role.secondary_time_period? || current_user.role.finance_admin?
                    @departmental_sdbips = @departmental_sdbips
                end
                if !current_user.role.blank? && current_user.role.kpi_owner? && !current_user.kpi_owners.blank? # && (current_user.subdepartmental_administrator.blank? || current_user.departmental_administrator.blank?)
                    kpi_id = current_user.kpi_owners.ids
                    @departmental_sdbips = @departmental_sdbips.where(:kpi_owner_id => params[:kpi_id]) unless @departmental_sdbips.blank?
                end
                if !current_user.subdepartmental_administrator.blank? && current_user.kpi_owners.blank?
                    subdepartment_id = current_user.subdepartmental_administrator.subdepartment_id
                    @departmental_sdbips = @departmental_sdbips.where(subdepartment_id: subdepartment_id) unless @departmental_sdbips.blank?
                end
                if !current_user.departmental_administrator.blank? && current_user.kpi_owners.blank?
                    department_id = current_user.departmental_administrator.department_id
                    @departmental_sdbips = @departmental_sdbips.where(:department_id => params[:department_id]) unless @departmental_sdbips.blank?
                end
                if !@departmental_sdbips.blank?
                    @departmental_sdbips = @departmental_sdbips.includes(:department, :subdepartment, :kpi_type, :kpi_owner, :mscore_classification, :national_outcome, :strategic_objective, :risk_rating, :kpa, :ndp_objective, :capital_project, :kpi_concept, :area, :ward, :reporting_category, :kpi_calculation_type).paginate(per_page: 15, page: params[:page]).order(id: :asc)
                else
                    @departmental_sdbips = nil
                end
        elsif !params[:subdepartment_id] && (!current_user.role.blank? || current_user.admin? || current_user.super_admin?)
                @periods = KpiResult.pluck(:period).map{|x| x.month}.uniq
                @result_periods = KpiResult.select(:period)
                @departmental_sdbips = DepartmentalSdbip.all
                if current_user.admin? || current_user.super_admin? || current_user.role.audit_log_reporting? || current_user.role.top_layer_administrator? || current_user.role.assurance_provider? || current_user.role.secondary_time_period? || current_user.role.finance_admin?
                    @departmental_sdbips = @departmental_sdbips
                end
                if !current_user.role.blank? && current_user.role.kpi_owner? && !current_user.kpi_owners.blank? # && (current_user.subdepartmental_administrator.blank? || current_user.departmental_administrator.blank?)
                    kpi_id = current_user.kpi_owners.ids
                    @departmental_sdbips = @departmental_sdbips.where(kpi_owner_id: kpi_id)
                end
                if !current_user.subdepartmental_administrator.blank? && current_user.kpi_owners.blank?
                    subdepartment_id = current_user.subdepartmental_administrator.subdepartment_id
                    @departmental_sdbips = @departmental_sdbips.where(subdepartment_id: subdepartment_id)
                end
                if !current_user.departmental_administrator.blank? && current_user.kpi_owners.blank?
                    department_id = current_user.departmental_administrator.department_id
                    @departmental_sdbips = @departmental_sdbips.where(department_id: department_id)
                end
                if !@departmental_sdbips.blank?
                    @departmental_sdbips = @departmental_sdbips.paginate(per_page: 15, page: params[:page]).includes(:capital_project, :department, :subdepartment, :kpi_type, :kpi_owner, :kpi_concept, :kpi_calculation_type, :mscore_classification, :kpa, :strategic_objective, :national_outcome, :reporting_category, :ndp_objective, :risk_rating,:kpi_results).order(id: :asc)
                else
                    @departmental_sdbips = nil
                end
        end
        respond_to do |format|
            format.html
            format.csv { send_data @departmental_sdbips_to_file.to_csv }
            format.xls { send_data @departmental_sdbips_to_file.to_csv(col_sep: "\t") }
        end
    end

    def restore_kpi
        @deleted_kpi = DepartmentalKpi.find(params[:id])
        DepartmentalSdbip.create(@deleted_kpi.attributes).save if @deleted_kpi
        @deleted_kpi.destroy
        flash[:success] = 'KPI was successfully restored.'
        redirect_to departmental_sdbips_path
    end

    def show
        @time_periods = SdbipTimePeriod.all
    end

    def new
        @departmental_sdbip = DepartmentalSdbip.new
    end

    def create
        @departmental_sdbip = DepartmentalSdbip.new(departmental_sdbip_params)
        if @departmental_sdbip.save
            flash[:success] = 'KPI was successfully saved.'
            redirect_to departmental_sdbips_path
        else
            flash[:danger] = 'KPI was not saved. please fill all the required fields.'
            redirect_to departmental_sdbips_path
        end
    end

    def audit_performance
        @time_periods = SdbipTimePeriod.all
        @departmental_sdbip = DepartmentalSdbip.find(params[:id])
        if @departmental_sdbip.assurances.where('extract(month from created_at) = ? AND extract(year from created_at) = ? AND departmental_sdbip_id = ? ', Date.today.month, Date.today.year, @departmental_sdbip.id).any?
        else
          @departmental_sdbip.assurances.build
        end
    end

    def edit
        @time_periods = SdbipTimePeriod.all
        if @departmental_sdbip.kpi_results.where('extract(month from period) = ? AND extract(year from period) = ? AND departmental_sdbip_id = ? ', Date.today.month, Date.today.year, @departmental_sdbip.id).any?
        else
          @departmental_sdbip.kpi_results.build
        end
    end

    def edit_kpis
        @time_periods = SdbipTimePeriod.all
    end

    def update
        # @departmental_sdbip.kpi_results.user_id = current_user.id
        # @departmental_sdbip.assurances.user_id = current_user.id

        if @departmental_sdbip.update(departmental_sdbip_params)
            # audit_log(departmental_sdbip_id)
            flash[:success] = 'KPI was successfully updated'
            redirect_to :back
        else
            flash[:danger] = 'KPI was not updated'
            redirect_to :back
        end
    end

    def import
        if params[:file].nil?
            flash[:danger] = 'You have not selected a file'
            redirect_to departmental_sdbips_path
        else
            begin
                # FileUtils.mv(file_location, '/db/data/')
                # temp = Tempfile.new(params[:file].original_filename)
                # xlsx_package.serialize temp.path
                # send_file temp.path, :filename => params[:file].original_filename, :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                DepartmentalSdbip.import_from_file(params[:file])
                flash[:success] = 'SDBIP submitted successfully for processing.'
                redirect_to departmental_sdbips_path
            rescue => e
                flash[:danger] = "SDBIP failed to import #{e.message}."
                Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
                # temp.close
                # temp.unlink
                redirect_to :back
            end
          # redirect_to departmental_sdbips_path
      end
    end

    def destroy
        @departmental_sdbip = DepartmentalSdbip.find(params[:id])
        DepartmentalKpi.create(@departmental_sdbip.attributes).save if @departmental_sdbip
        @departmental_sdbip.destroy
        flash[:success] = 'KPI deleted successfully.'
        redirect_to departmental_sdbips_path
    end

    private

    def departmental_sdbip_params
        params.require(:departmental_sdbip).permit(:name, :department_name, :kpa_name, :department_id,
                                                   :subdepartment_id, :kpi_ref_number, :mscore_classification_id, :idp_ref, :national_outcome_id, :strategic_objective_id,
                                                   :kpa_id, :kpi_target_type_id,
                                                   :predetermined_objective_id, :ndp_objective_id,
                                                   :capital_project_id, :kpi, :unit_of_measurement,
                                                   :kpi_concept_id, :kpi_type_id, :risk_reg_ref,
                                                   :comments, :risk_rating_id, :wards, :areas,
                                                   :kpi_owner_id, :baseline, :past_year_performance,
                                                   :performance_standard, :proof_of_evidence, :mtas_indicator,
                                                   :reporting_category_id, :provincial_strategic_outcome_id,
                                                   :source_of_evidence, :target, :annual_target, :budget, :impact, :top_layer_kpi_ref, :mtas_indicator_id,
                                                   :kpi_calculation_type_id,:first_quarter_target,:second_quarter_target,:third_quarter_target,:fourth_quarter_target,:first_quarter_actual,:second_quarter_actual,:third_quarter_actual,:fourth_quarter_actual,
                                                   :first_quarter_results,:second_quarter_results,:third_quarter_results,:fourth_quarter_results,
                                                   :kpi_target_type_id, :annual_target, :revised_target, assurances_attributes: [:id, :user_id, :signed_off, :response, :kpi_result_id, :poe], kpi_results_attributes: [:id, :target, :actual, :kpi_performance_standard, :user_id, :performance_comments, :corrective_measures, :_destroy, :period, attachments_attributes: [:id, :poe, :_destroy]])
    end

    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = 'Please log in.'
            redirect_to login_url
        end
    end

    def set_departmental_sdbip
        @departmental_sdbip = DepartmentalSdbip.find(params[:id])
    end

    # Confirms an admin user.
    def admin_user
        # redirect_to(root_url) unless
        current_user.admin? # || correct_user?
    end

    def correct_user
        redirect_to(root_url) unless !current_user.role.blank? || current_user.admin? || current_user.super_admin? # !current_user.role.blank? && (current_user.role.audit_log_reporting? || current_user.role.assurance_provider? || !current_user.kpi_owner.blank? && current_user.role.kpi_owner? || !current_user.departmental_administrator.blank? || !current_user.subdepartmental_administrator.blank? )
    end
end
