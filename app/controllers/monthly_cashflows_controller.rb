class MonthlyCashflowsController < ApplicationController
  before_action :set_monthly_cashflow, only: [:show, :edit, :update, :destroy]

  # GET /monthly_cashflows
  # GET /monthly_cashflows.json
  def index
    @monthly_cashflow = MonthlyCashflow.new
    @monthly_cashflows = MonthlyCashflow.all
    if !@monthly_cashflows.blank?
      @monthly_cashflows =  @monthly_cashflows.paginate(page: params[:page],per_page: 10)
    end
  end

  # GET /monthly_cashflows/1
  # GET /monthly_cashflows/1.json
  def show
  end

  # GET /monthly_cashflows/new
  def new
    @monthly_cashflow = MonthlyCashflow.new
  end

  # GET /monthly_cashflows/1/edit
  def edit
  end

  # POST /monthly_cashflows
  # POST /monthly_cashflows.json
  def create
    @monthly_cashflow = MonthlyCashflow.new(monthly_cashflow_params)

    respond_to do |format|
      if @monthly_cashflow.save
        flash[:success] = 'Monthly cashflow was successfully created.'
        format.html { redirect_to monthly_cashflows_url}
        format.json { render :show, status: :created, location: @monthly_cashflow }
      else
        format.html { render monthly_cashflows_url }
        format.json { render json: @monthly_cashflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monthly_cashflows/1
  # PATCH/PUT /monthly_cashflows/1.json
  def update
    respond_to do |format|
      if @monthly_cashflow.update(monthly_cashflow_params)
        flash[:success] = 'Monthly cashflow was successfully updated.'
        format.html { redirect_to monthly_cashflows_url}
        format.json { render :show, status: :ok, location: @monthly_cashflow }
      else
        format.html { render monthly_cashflows_url }
        format.json { render json: @monthly_cashflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthly_cashflows/1
  # DELETE /monthly_cashflows/1.json
  def destroy
    @monthly_cashflow.destroy
    flash[:success] = 'Monthly cashflow was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to monthly_cashflows_url }
      format.json { head :no_content }
    end
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
end
