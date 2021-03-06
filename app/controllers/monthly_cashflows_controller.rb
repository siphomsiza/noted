class MonthlyCashflowsController < ApplicationController
  before_action :set_monthly_cashflow, only: [:show, :edit, :update,:edit_monthly_cashflows, :destroy]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy,:edit_monthly_cashflows]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy,:create,:edit_monthly_cashflows]

  # GET /monthly_cashflows
  # GET /monthly_cashflows.json
  def index
    weather_details
    @monthly_cashflow = MonthlyCashflow.new
    @monthly_cashflows = MonthlyCashflow.paginate(page: params[:page],per_page: 10)
  end

  # GET /monthly_cashflows/1
  # GET /monthly_cashflows/1.json
  def show
  end
  # GET /monthly_cashflows/1/edit
  def edit
  end

  def edit_monthly_cashflows
  end

  # POST /monthly_cashflows
  # POST /monthly_cashflows.json
  def create
    @monthly_cashflow = MonthlyCashflow.new(monthly_cashflow_params)
      if @monthly_cashflow.save
        flash[:success] = 'Monthly cashflow was successfully created.'
        redirect_to monthly_cashflows_url

      else
        flash[:danger] = 'Monthly cashflow was not created.'
        redirect_to monthly_cashflows_url
    end
  end

  # PATCH/PUT /monthly_cashflows/1
  # PATCH/PUT /monthly_cashflows/1.json
  def update

      if @monthly_cashflow.update(monthly_cashflow_params)
        flash[:success] = 'Monthly cashflow was successfully updated.'
        redirect_to monthly_cashflows_url

      else
        flash[:danger] = 'Monthly cashflow was not updated.'
        redirect_to monthly_cashflows_url
    end
  end

  # DELETE /monthly_cashflows/1
  # DELETE /monthly_cashflows/1.json
  def destroy
    @monthly_cashflow.destroy
    flash[:success] = 'Monthly cashflow was successfully deleted.'
    redirect_to monthly_cashflows_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_cashflow
      @monthly_cashflow = MonthlyCashflow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthly_cashflow_params
      params.require(:monthly_cashflow).permit(:month, :vote_number, :subdepartment_id, :department_id, :mscore_classification_id, :line_item, :operational_expenditure, :revenue, :capital_expenditure)
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
