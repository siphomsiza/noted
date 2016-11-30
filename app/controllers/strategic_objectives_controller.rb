class StrategicObjectivesController < ApplicationController
  before_action :set_strategic_objective, only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?

  # GET /strategic_objectives/new
  def new
    @strategic_objective = StrategicObjective.new
  end

  # GET /strategic_objectives/1/edit
  def edit
  end

  # POST /strategic_objectives
  # POST /strategic_objectives.json
  def create
    @strategic_objective = StrategicObjective.new(strategic_objective_params)

      if @strategic_objective.save
        flash[:success] = 'Strategic objective was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Strategic objective was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /strategic_objectives/1
  # PATCH/PUT /strategic_objectives/1.json
  def update

      if @strategic_objective.update(strategic_objective_params)
        flash[:success] = 'Strategic objective was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Strategic objective was not updated.'
        redirect_to :back
      end
  end

  # DELETE /strategic_objectives/1
  # DELETE /strategic_objectives/1.json
  def destroy
    @strategic_objective.destroy
    flash[:success] = 'Strategic objective was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_strategic_objective
      @strategic_objective = StrategicObjective.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def strategic_objective_params
      params.require(:strategic_objective).permit(:name)
    end
end
