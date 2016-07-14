class CapitalProjectsController < ApplicationController
  before_action :set_capital_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy]

  # GET /capital_projects
  # GET /capital_projects.json
  def index

    @capital_project = CapitalProject.new
    @capital_projects = CapitalProject.all
      if !@capital_projects.blank?
       @capital_projects =  @capital_projects.paginate(page: params[:page],per_page: 15)
      end
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
    rescue=> e

       Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
      flash[:danger] = "Capital Projects failed to import #{e.message}."
       redirect_to capital_projects_url
    end
  end
  end
  # GET /capital_projects/1/edit
  def edit
  end

  # POST /capital_projects
  # POST /capital_projects.json
  def create
    @capital_project = CapitalProject.new(capital_project_params)

    respond_to do |format|
      if @capital_project.save
        flash[:success] = 'Capital project was successfully created.'
        format.html { redirect_to capital_projects_url }
        format.json { render :show, status: :created, location: @capital_project }
      else
        flash[:danger] = 'Capital project was not created.'
        format.html { redirect_to capital_projects_url }
        format.json { render json: @capital_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /capital_projects/1
  # PATCH/PUT /capital_projects/1.json
  def update

      if @capital_project.update(capital_project_params)
          flash[:success] ='Capital project was successfully updated.'
          redirect_to capital_projects_url
      else

           flash[:success] ='Capital project was not updated.'
           redirect_to capital_projects_url
    end
  end

  # DELETE /capital_projects/1
  # DELETE /capital_projects/1.json
  def destroy
    @capital_project.destroy
    flash[:success]='Capital project was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to capital_projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_capital_project
      @capital_project = CapitalProject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def capital_project_params
      params.require(:capital_project).permit(:department_id, :subdepartment_id, :mscore_classification_id, :mun_cp_ref, :idp_nummber, :vote_number, :project_name, :project_description, :funding_source, :planned_start_date, :planned_completion_date, :actual_start_date, :actual_completion_date, :ward_id, :area_id, :july, :august, :september, :october, :november, :december, :january, :february, :march, :april, :may, :june)
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
