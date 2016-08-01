class MtasIndicatorsController < ApplicationController
  before_action :set_mtas_indicator, only: [:show, :edit, :update, :destroy]

  # GET /mtas_indicators
  # GET /mtas_indicators.json
  def index
    @mtas_indicators = MtasIndicator.all
  end

  # GET /mtas_indicators/1
  # GET /mtas_indicators/1.json
  def show
  end

  # GET /mtas_indicators/new
  def new
    @mtas_indicator = MtasIndicator.new
  end

  # GET /mtas_indicators/1/edit
  def edit
  end

  # POST /mtas_indicators
  # POST /mtas_indicators.json
  def create
    @mtas_indicator = MtasIndicator.new(mtas_indicator_params)

      if @mtas_indicator.save
        flash[:success] = 'Mtas indicator was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Mtas indicator was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /mtas_indicators/1
  # PATCH/PUT /mtas_indicators/1.json
  def update

      if @mtas_indicator.update(mtas_indicator_params)
        flash[:success] = 'Mtas indicator was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Mtas indicator was not updated.'
        redirect_to :back
      end
  end

  # DELETE /mtas_indicators/1
  # DELETE /mtas_indicators/1.json
  def destroy
    @mtas_indicator.destroy
      flash[:success] = 'Mtas indicator was successfully destroyed.'
      redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mtas_indicator
      @mtas_indicator = MtasIndicator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mtas_indicator_params
      params.require(:mtas_indicator).permit(:name)
    end
end
