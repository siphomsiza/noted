class PredeterminedObjectivesController < ApplicationController
  before_action :set_predetermined_objective, only: [:show, :edit, :update, :destroy]

  # GET /predetermined_objectives
  # GET /predetermined_objectives.json
  def index
    @predetermined_objectives = PredeterminedObjective.all
  end

  # GET /predetermined_objectives/1
  # GET /predetermined_objectives/1.json
  def show
  end

  # GET /predetermined_objectives/new
  def new
    @predetermined_objective = PredeterminedObjective.new
  end

  # GET /predetermined_objectives/1/edit
  def edit
  end

  # POST /predetermined_objectives
  # POST /predetermined_objectives.json
  def create
    @predetermined_objective = PredeterminedObjective.new(predetermined_objective_params)

      if @predetermined_objective.save
        flash[:success] = 'Predetermined Objective was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Predetermined Objective was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /predetermined_objectives/1
  # PATCH/PUT /predetermined_objectives/1.json
  def update
      if @predetermined_objective.update(predetermined_objective_params)
        flash[:success] = 'Predetermined Objective was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Predetermined Objective was not updated.'
        redirect_to :back
      end
  end

  # DELETE /predetermined_objectives/1
  # DELETE /predetermined_objectives/1.json
  def destroy
    @predetermined_objective.destroy
    flash[:success] = 'Predetermined Objective was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_predetermined_objective
      @predetermined_objective = PredeterminedObjective.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def predetermined_objective_params
      params.require(:predetermined_objective).permit(:name)
    end
end
