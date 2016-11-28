class KpiConceptsController < ApplicationController
  before_action :set_kpi_concept, only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?
  # GET /kpi_concepts/new
  def new
    @kpi_concept = KpiConcept.new
  end

  # GET /kpi_concepts/1/edit
  def edit
  end

  # POST /kpi_concepts
  # POST /kpi_concepts.json
  def create
    @kpi_concept = KpiConcept.new(kpi_concept_params)

      if @kpi_concept.save
        flash[:success] =  'KPI Concept was successfully created.'
        redirect_to :back
      else
        flash[:danger] =  'KPI Concept was not created.'
        redirect_to :back
      end

  end

  # PATCH/PUT /kpi_concepts/1
  # PATCH/PUT /kpi_concepts/1.json
  def update

      if @kpi_concept.update(kpi_concept_params)
        flash[:success] =  'KPI Concept was successfully updated.'
        redirect_to :back
      else
        flash[:danger] =  'KPI Concept was not updated.'
        redirect_to :back
      end

  end

  # DELETE /kpi_concepts/1
  # DELETE /kpi_concepts/1.json
  def destroy
    @kpi_concept.destroy
    flash[:success] =  'KPI Concept was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_kpi_concept
      @kpi_concept = KpiConcept.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kpi_concept_params
      params.require(:kpi_concept).permit(:name, :code)
    end
end
