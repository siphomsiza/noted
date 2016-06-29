class RolesController < ApplicationController
  def index
    @role = Role.new
    @roles = Role.all
    @users = User.all
    @departments = Department.all
  end

  def show
    @role = Role.find(params[:id])
  end
  def edit_user_role
    @role = Role.find(params[:id])
  end
  def new
    @role = Role.new
    @role.roles_details.build
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      flash[:success]= "Role was successfully created"
      redirect_to roles_path
    else
      flash[:danger]= "Role was not created"
      redirect_to roles_path
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
        @role = Role.find(params[:id])

    if @role.update_attributes(role_params)
      flash[:success] = "Role was successfully updated"
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
      flash[:success] = "Role was successfully deleted"
      redirect_to roles_path
  end

  private
    def role_params
        params.require(:role).permit(:user_id, :kpi_owner_id,
          :kpi_owner, :municipal_manager, :departmental_administrator,:subdepartmental_administrator,
          :auditor_general,:finance_admin, :internal_auditor, :roles_details_attributes=>[:id,:department_id,:subdepartment_id,:_destroy],)
    end
end
