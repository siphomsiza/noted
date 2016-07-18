class SubdepartmentalAdministratorsController < ApplicationController
  before_action :set_subdepartmental_administrator, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy]
  # GET /subdepartmental_administrators
  # GET /subdepartmental_administrators.json
  def index
    @subdepartmental_administrator = SubdepartmentalAdministrator.new
    @subdepartmental_administrators = SubdepartmentalAdministrator.includes(:user,:subdepartment)
  end

  # GET /subdepartmental_administrators/1
  # GET /subdepartmental_administrators/1.json
  def show
  end

  # GET /subdepartmental_administrators/new
  def new
    @subdepartmental_administrator = SubdepartmentalAdministrator.new
  end

  # GET /subdepartmental_administrators/1/edit
  def edit
  end

  # POST /subdepartmental_administrators
  # POST /subdepartmental_administrators.json
  def create
    @subdepartmental_administrator = SubdepartmentalAdministrator.new(subdepartmental_administrator_params)

      if @subdepartmental_administrator.save
        flash[:success] = 'Subdepartmental administrator was successfully created.'
        redirect_to :back

      else
        flash[:success] = 'Subdepartmental administrator was not created.'
        redirect_to :back
     end
  end

  # PATCH/PUT /subdepartmental_administrators/1
  # PATCH/PUT /subdepartmental_administrators/1.json
  def update

      if @subdepartmental_administrator.update(subdepartmental_administrator_params)
        flash[:success] = 'Subdepartmental administrator was successfully updated.'
        redirect_to @subdepartmental_administrator
      else
        flash[:danger] = 'Subdepartmental administrator was not updated.'
        redirect_to :back

    end
  end

  # DELETE /subdepartmental_administrators/1
  # DELETE /subdepartmental_administrators/1.json
  def destroy
    @subdepartmental_administrator.destroy
      flash[:success] = 'Subdepartmental administrator was successfully deleted.'
      redirect_to :back

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subdepartmental_administrator
      @subdepartmental_administrator = SubdepartmentalAdministrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subdepartmental_administrator_params
      params.require(:subdepartmental_administrator).permit(:subdepartment_id, :user_id, :can_create, :can_edit, :can_update, :can_approve)
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
