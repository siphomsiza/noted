class KpiTypesController < ApplicationController
  before_action :set_kpi_type, only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?
  # GET /kpi_types/new
  def new
    @kpi_type = KpiType.new
  end

  # GET /kpi_types/1/edit
  def edit
  end

  # POST /kpi_types
  # POST /kpi_types.json
  def create
    @kpi_type = KpiType.new(kpi_type_params)

      if @kpi_type.save
        flash[:success] = 'KPI Type was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'KPI Type was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /kpi_types/1
  # PATCH/PUT /kpi_types/1.json
  def update

      if @kpi_type.update(kpi_type_params)
        flash[:success] = 'KPI Type was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'KPI Type was not updated.'
        redirect_to :back
      end

  end

  # DELETE /kpi_types/1
  # DELETE /kpi_types/1.json
  def destroy
    @kpi_type.destroy
    flash[:success] = 'KPI Type was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_kpi_type
      @kpi_type = KpiType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kpi_type_params
      params.require(:kpi_type).permit(:name,:code)
    end
end
