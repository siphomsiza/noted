class CapitalProjectsController < ApplicationController
  before_action :set_capital_project, only: [:show, :edit, :update, :destroy]

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
    rescue
      flash[:danger] = "Capital Projects failed to import."
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
    respond_to do |format|
      if @capital_project.update(capital_project_params)
          flash[:success] ='Capital project was successfully updated.'
        format.html { redirect_to capital_projects_url }
        format.json { render :show, status: :ok, location: @capital_project }
      else
          format.html { redirect_to capital_projects_url }
        format.json { render json: @capital_project.errors, status: :unprocessable_entity }
      end
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
end
