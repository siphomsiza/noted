class KpiTargetTypesController < ApplicationController
  before_action :set_kpi_target_type, only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?
  # GET /kpi_target_types/new
  def new
    @kpi_target_type = KpiTargetType.new
  end

  # GET /kpi_target_types/1/edit
  def edit
  end

  # POST /kpi_target_types
  # POST /kpi_target_types.json
  def create
    @kpi_target_type = KpiTargetType.new(kpi_target_type_params)


      if @kpi_target_type.save
        flash[:success] =  'KPI Target Type was successfully created.'
        redirect_to :back
      else
        flash[:danger] =  'KPI Target Type was not created.'
        redirect_to :back
      end

  end

  # PATCH/PUT /kpi_target_types/1
  # PATCH/PUT /kpi_target_types/1.json
  def update

      if @kpi_target_type.update(kpi_target_type_params)
        flash[:success] =  'KPI Target Type was successfully updated.'
        redirect_to :back
      else
        flash[:danger] =  'KPI Target Type was not updated.'
        redirect_to :back
      end
  end

  # DELETE /kpi_target_types/1
  # DELETE /kpi_target_types/1.json
  def destroy
    @kpi_target_type.destroy
    flash[:success] =  'KPI Target Type was not created.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_kpi_target_type
      @kpi_target_type = KpiTargetType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kpi_target_type_params
      params.require(:kpi_target_type).permit(:name, :code)
    end
end
