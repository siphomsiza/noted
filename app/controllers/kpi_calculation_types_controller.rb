class KpiCalculationTypesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
    @kpi_calculation_types = KpiCalculationType.all
  end

  def show
    @kpi_calculation_type = KpiCalculationType.find(params[:id])
    @roles = KpiCalculationType.includes(:role).all
  end

  def new
    @kpi_calculation_type = KpiCalculationType.new
  end

  def create
    @kpi_calculation_type = KpiCalculationType.new(kpi_calculation_type_params)
    if @kpi_calculation_type.save
      redirect_to kpi_calculation_types_path, :notice => "KPI Calculation Type was successfully created"
    else
      render "new"
    end
  end

  def edit
    @kpi_calculation_type = KpiCalculationType.find(params[:id])
  end

  def update
    @kpi_calculation_type = KpiCalculationType.find(params[:id])

    if @kpi_calculation_type.update_attributes(kpi_calculation_type_params)
      redirect_to kpi_calculation_types_path, :notice => "KPI Calculation Type was successfully updated"
    else
      render "edit"
    end
  end

  def destroy
    @kpi_calculation_type = KpiCalculationType.find(params[:id])
    @kpi_calculation_type.destroy

    redirect_to kpi_calculation_types_path
  end

  private
    def kpi_calculation_type_params
        params.require(:kpi_calculation_type).permit( :name, :sdbip_id,
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
