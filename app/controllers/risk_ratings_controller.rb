class RiskRatingsController < ApplicationController
  before_action :set_risk_rating, only: [:show, :edit, :update, :destroy]

  # GET /risk_ratings
  # GET /risk_ratings.json
  def index
    @risk_ratings = RiskRating.all
  end

  # GET /risk_ratings/1
  # GET /risk_ratings/1.json
  def show
  end

  # GET /risk_ratings/new
  def new
    @risk_rating = RiskRating.new
  end

  # GET /risk_ratings/1/edit
  def edit
  end

  # POST /risk_ratings
  # POST /risk_ratings.json
  def create
    @risk_rating = RiskRating.new(risk_rating_params)


      if @risk_rating.save
        flash[:success] = 'Risk Rating was successfully created.'
        redirect_to :back
      else
        flash[:success] = 'Risk Rating was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /risk_ratings/1
  # PATCH/PUT /risk_ratings/1.json
  def update

      if @risk_rating.update(risk_rating_params)
        flash[:success] = 'Risk Rating was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Risk Rating was not updated.'
        redirect_to :back
      end
  end

  # DELETE /risk_ratings/1
  # DELETE /risk_ratings/1.json
  def destroy
    @risk_rating.destroy

      flash[:success] = 'Risk Rating was successfully destroyed.'
      redirect_to :back

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_risk_rating
      @risk_rating = RiskRating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def risk_rating_params
      params.require(:risk_rating).permit(:name, :code)
    end
end
