class KpasController < ApplicationController
  before_action :set_kpa, only: [:show, :edit, :update, :destroy]

  # GET /kpas
  # GET /kpas.json
  def index
    @kpas = Kpa.all
  end

  # GET /kpas/1
  # GET /kpas/1.json
  def show
  end

  # GET /kpas/new
  def new
    @kpa = Kpa.new
  end

  # GET /kpas/1/edit
  def edit
  end

  # POST /kpas
  # POST /kpas.json
  def create
    @kpa = Kpa.new(kpa_params)

      if @kpa.save
        flash[:success] = 'KPA was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'KPA was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /kpas/1
  # PATCH/PUT /kpas/1.json
  def update

      if @kpa.update(kpa_params)
        flash[:success] = 'KPA was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'KPA was not updated.'
        redirect_to :back
      end
  end

  # DELETE /kpas/1
  # DELETE /kpas/1.json
  def destroy
    @kpa.destroy
    flash[:success] = 'KPA was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kpa
      @kpa = Kpa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kpa_params
      params.require(:kpa).permit(:name)
    end
end
