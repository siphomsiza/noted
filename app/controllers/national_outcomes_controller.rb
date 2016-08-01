class NationalOutcomesController < ApplicationController
  before_action :set_national_outcome, only: [:show, :edit, :update, :destroy]

  # GET /national_outcomes
  # GET /national_outcomes.json
  def index
    @national_outcomes = NationalOutcome.all
  end

  # GET /national_outcomes/1
  # GET /national_outcomes/1.json
  def show
  end

  # GET /national_outcomes/new
  def new
    @national_outcome = NationalOutcome.new
  end

  # GET /national_outcomes/1/edit
  def edit
  end

  # POST /national_outcomes
  # POST /national_outcomes.json
  def create
    @national_outcome = NationalOutcome.new(national_outcome_params)


      if @national_outcome.save
        flash[:success] = 'National outcome was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'National outcome was not created.'
        redirect_to :back
      end

  end

  # PATCH/PUT /national_outcomes/1
  # PATCH/PUT /national_outcomes/1.json
  def update

      if @national_outcome.update(national_outcome_params)
        flash[:success] = 'National outcome was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'National outcome was not updated.'
        redirect_to :back
      end

  end

  # DELETE /national_outcomes/1
  # DELETE /national_outcomes/1.json
  def destroy
    @national_outcome.destroy
    flash[:success] = 'National outcome was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_national_outcome
      @national_outcome = NationalOutcome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def national_outcome_params
      params.require(:national_outcome).permit(:name)
    end
end
