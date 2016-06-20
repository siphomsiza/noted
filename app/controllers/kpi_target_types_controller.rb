class KpiTargetTypesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
    @kpi_target_types = KpiTargetType.all
  end

  def show
    @kpi_target_type = KpiTargetType.find(params[:id])
    @roles = KpiTargetType.includes(:role).all
  end

  def new
    @kpi_target_type = KpiTargetType.new
  end

  def create
    @kpi_target_type = KpiTargetType.new(kpi_target_type_params)
    if @kpi_target_type.save
      redirect_to kpi_target_types_path, :notice => "KPI Calculation Type was successfully created"
    else
      render "new"
    end
  end

  def edit
    @kpi_target_type = KpiTargetType.find(params[:id])
  end

  def update
    @kpi_target_type = KpiTargetType.find(params[:id])

    if @kpi_target_type.update_attributes(kpi_target_type_params)
      redirect_to kpi_target_types_path, :notice => "KPI Calculation Type was successfully updated"
    else
      render "edit"
    end
  end

  def destroy
    @kpi_target_type = KpiTargetType.find(params[:id])
    @kpi_target_type.destroy

    redirect_to kpi_target_types_path
  end

  private
    def kpi_target_type_params
        params.require(:kpi_target_type).permit( :name, :sdbip_id,
          :description)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      # TO DO: Do this properly
      #redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
