class DepartmentalAdministratorsController < ApplicationController
  before_action :set_departmental_administrator, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy]
  # GET /departmental_administrators
  # GET /departmental_administrators.json
  def index
    weather_details
    @users_for_departmental_administrators = User.where('id NOT IN(SELECT (user_id) FROM top_layer_administrators)')
    @subdepartments = Subdepartment.includes(subdepartmental_administrators:[:user])
    @departments = Department.includes(top_layer_administrators:[:user],departmental_administrators:[:user])
    @kpi_owners = KpiOwner.includes(:user).paginate(page: params[:page],per_page: 10)
    @top_layer_administrator = TopLayerAdministrator.new
    #@departments = Department.includes(:top_layer_administrators).paginate(page: params[:page],per_page: 10)
    @kpi_owner = KpiOwner.new
    @departmental_administrator = DepartmentalAdministrator.new
    @subdepartmental_administrator = SubdepartmentalAdministrator.new
  end

  # GET /departmental_administrators/1
  # GET /departmental_administrators/1.json
  def show
  end

  # GET /departmental_administrators/1/edit
  def edit
  end

  # POST /departmental_administrators
  # POST /departmental_administrators.json
  def create
    @departmental_administrator = DepartmentalAdministrator.new(departmental_administrator_params)
    begin
      if @departmental_administrator.save
        flash[:success] = 'Departmental administrator was successfully created.'
      else
        flash[:danger] = "Departmental administrator was not created."
      end
    rescue
    end
     redirect_to :back
  end

  # PATCH/PUT /departmental_administrators/1
  # PATCH/PUT /departmental_administrators/1.json
  def update

      if @departmental_administrator.update(departmental_administrator_params)
        flash[:success] = 'Departmental administrator was successfully updated.'
      else
        flash[:danger] = 'Departmental administrator was not updated.'
      end
      redirect_to :back
  end

  # DELETE /departmental_administrators/1
  # DELETE /departmental_administrators/1.json
  def destroy
    @departmental_administrator.destroy
    flash[:success] = 'Departmental administrator was successfully deleted.'
    redirect_to departmental_administrators_url

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departmental_administrator
      @departmental_administrator = DepartmentalAdministrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departmental_administrator_params
      params.require(:departmental_administrator).permit(:department_id, :user_id, :can_create, :can_edit, :can_update, :can_approve)
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
        redirect_to(root_url) unless current_user.admin? || current_user.super_admin?
      end

end
