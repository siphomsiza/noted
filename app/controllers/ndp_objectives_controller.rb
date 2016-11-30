class NdpObjectivesController < ApplicationController
  before_action :set_ndp_objective, only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?

  # GET /ndp_objectives/new
  def new
    @ndp_objective = NdpObjective.new
  end

  # GET /ndp_objectives/1/edit
  def edit
  end

  # POST /ndp_objectives
  # POST /ndp_objectives.json
  def create
    @ndp_objective = NdpObjective.new(ndp_objective_params)

      if @ndp_objective.save
        flash[:success] = 'NDP objective was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'NDP objective was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /ndp_objectives/1
  # PATCH/PUT /ndp_objectives/1.json
  def update
      if @ndp_objective.update(ndp_objective_params)
        flash[:success] = 'NDP objective was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'NDP objective was not updated.'
        redirect_to :back
      end
  end

  # DELETE /ndp_objectives/1
  # DELETE /ndp_objectives/1.json
  def destroy
    @ndp_objective.destroy
    flash[:success] = 'NDP objective was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_ndp_objective
      @ndp_objective = NdpObjective.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ndp_objective_params
      params.require(:ndp_objective).permit(:name)
    end
end
