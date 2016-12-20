class CapitalProjectsController < ApplicationController
  #before_filter :authenticate
  before_action :set_capital_project, only: [:show, :edit, :update, :destroy,:edit_capital_projects]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy,:edit_capital_projects]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy,:edit_capital_projects]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?
  # GET /capital_projects
  # GET /capital_projects.json
  def index
    weather_details
    @capital_project = CapitalProject.new
    @capital_projects = CapitalProject.all.order(id: :asc).paginate(page: params[:page],per_page: 15).includes(:departmental_sdbip,:mscore_classification,subdepartment: [:department])
  end

  # GET /capital_projects/1
  # GET /capital_projects/1.json
  def show
  end

  # GET /capital_projects/new
  def new
    @capital_project = CapitalProject.new
  end
  def import
    if params[:file].nil?
       flash[:danger] = 'You have not selected a file'
      redirect_to capital_projects_url
    else
    begin
       CapitalProject.import(params[:file])
       flash[:success] = "Capital Projects imported successfully."
       redirect_to capital_projects_url
    rescue
      flash[:danger] = "Capital Projects failed to import."
       redirect_to capital_projects_url
    end
    end
  end
  # GET /capital_projects/1/edit
  def edit
  end

  def edit_capital_projects
  end

  # POST /capital_projects
  # POST /capital_projects.json
  def create
    @capital_project = CapitalProject.new(capital_project_params)

      if @capital_project.save
        flash[:success] = 'Capital Project was successfully created.'
      else
        flash[:danger] = 'Capital Project was not created.'
      end
    redirect_to :back
  end

  # PATCH/PUT /capital_projects/1
  # PATCH/PUT /capital_projects/1.json
  def update

      if @capital_project.update(capital_project_params)
          flash[:success] ='Capital Project was successfully updated.'
      else
           flash[:danger] ='Capital Project was not updated.'
      end
    redirect_to :back
  end

  # DELETE /capital_projects/1
  # DELETE /capital_projects/1.json
  def destroy
    @capital_project.destroy
    flash[:success]='Capital Project was successfully deleted.'

      redirect_to capital_projects_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
          request.format.js?
    end
    def set_capital_project
      @capital_project = CapitalProject.includes(:departmental_sdbip=>[:kpi_results]).find(params[:id])
      @time_periods = SdbipTimePeriod.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def capital_project_params
      params.require(:capital_project).permit( :mscore_classification_id, :subdepartment_id,:mun_cp_ref, :idp_nummber, :vote_number, :project_name, :departmental_sdbip_id, :funding_source, :planned_start_date, :planned_completion_date, :actual_start_date, :actual_completion_date, :ward_id, :area_id)
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
end
