class FundingSourcesController < ApplicationController
  before_action :set_funding_source, only: [:show, :edit, :update, :destroy]

  # GET /funding_sources
  # GET /funding_sources.json
  def index
    @funding_sources = FundingSource.all
  end

  # GET /funding_sources/1
  # GET /funding_sources/1.json
  def show
  end

  # GET /funding_sources/new
  def new
    @funding_source = FundingSource.new
  end

  # GET /funding_sources/1/edit
  def edit
  end

  # POST /funding_sources
  # POST /funding_sources.json
  def create
    @funding_source = FundingSource.new(funding_source_params)

      if @funding_source.save
        flash[:success] = 'Funding source was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Funding source was not created.'
        redirect_to :back
      end

  end

  # PATCH/PUT /funding_sources/1
  # PATCH/PUT /funding_sources/1.json
  def update

      if @funding_source.update(funding_source_params)
          flash[:success] =  'Funding source was successfully updated.'
          redirect_to :back
      else
        flash[:success] = 'Funding source was not updated.'
        redirect_to :back
      end

  end

  # DELETE /funding_sources/1
  # DELETE /funding_sources/1.json
  def destroy
    @funding_source.destroy
    flash[:success] = 'Funding source was successfully deleted.'
      redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding_source
      @funding_source = FundingSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funding_source_params
      params.require(:funding_source).permit(:name)
    end
end
