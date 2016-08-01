class KpiCalculationTypesController < ApplicationController
  before_action :set_kpi_calculation_type, only: [:show, :edit, :update, :destroy]

  # GET /kpi_calculation_types
  # GET /kpi_calculation_types.json
  def index
    @kpi_calculation_types = KpiCalculationType.all
  end

  # GET /kpi_calculation_types/1
  # GET /kpi_calculation_types/1.json
  def show
  end

  # GET /kpi_calculation_types/new
  def new
    @kpi_calculation_type = KpiCalculationType.new
  end

  # GET /kpi_calculation_types/1/edit
  def edit
  end

  # POST /kpi_calculation_types
  # POST /kpi_calculation_types.json
  def create
    @kpi_calculation_type = KpiCalculationType.new(kpi_calculation_type_params)

      if @kpi_calculation_type.save
        flash[:success] =  'KPI Calculation Type was successfully created.'
        redirect_to :back
      else
        flash[:danger] =  'KPI Calculation Type was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /kpi_calculation_types/1
  # PATCH/PUT /kpi_calculation_types/1.json
  def update

      if @kpi_calculation_type.update(kpi_calculation_type_params)
        flash[:success] =  'KPI Calculation Type was successfully updated.'
        redirect_to :back
      else
        flash[:danger] =  'KPI Calculation Type was not updated.'
        redirect_to :back
      end

  end

  # DELETE /kpi_calculation_types/1
  # DELETE /kpi_calculation_types/1.json
  def destroy
    @kpi_calculation_type.destroy

    flash[:success] =  'KPI Calculation Type was successfully deleted.'
    redirect_to :back

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kpi_calculation_type
      @kpi_calculation_type = KpiCalculationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kpi_calculation_type_params
      params.require(:kpi_calculation_type).permit(:name, :code)
    end
end
