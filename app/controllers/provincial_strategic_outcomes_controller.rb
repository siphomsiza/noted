class ProvincialStrategicOutcomesController < ApplicationController
  before_action :set_provincial_strategic_outcome, only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?

  # GET /provincial_strategic_outcomes/new
  def new
    @provincial_strategic_outcome = ProvincialStrategicOutcome.new
  end

  # GET /provincial_strategic_outcomes/1/edit
  def edit
  end

  # POST /provincial_strategic_outcomes
  # POST /provincial_strategic_outcomes.json
  def create
    @provincial_strategic_outcome = ProvincialStrategicOutcome.new(provincial_strategic_outcome_params)

      if @provincial_strategic_outcome.save
        flash[:success] = 'Predetermined Strategic Outcome was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Predetermined Strategic Outcome was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /provincial_strategic_outcomes/1
  # PATCH/PUT /provincial_strategic_outcomes/1.json
  def update

      if @provincial_strategic_outcome.update(provincial_strategic_outcome_params)
        flash[:success] = 'Predetermined Strategic Outcome was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Predetermined Strategic Outcome was not updated.'
        redirect_to :back
      end
  end

  # DELETE /provincial_strategic_outcomes/1
  # DELETE /provincial_strategic_outcomes/1.json
  def destroy
    @provincial_strategic_outcome.destroy
    flash[:success] = 'Predetermined Strategic Outcome was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_provincial_strategic_outcome
      @provincial_strategic_outcome = ProvincialStrategicOutcome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provincial_strategic_outcome_params
      params.require(:provincial_strategic_outcome).permit(:name)
    end
end
