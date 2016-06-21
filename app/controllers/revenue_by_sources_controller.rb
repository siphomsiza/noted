class RevenueBySourcesController < ApplicationController
  before_action :set_revenue_by_source, only: [:show, :edit, :update, :destroy]

  # GET /revenue_by_sources
  # GET /revenue_by_sources.json
  def index
    @revenue_by_source = RevenueBySource.new
    @revenue_by_sources = RevenueBySource.all
    if !@revenue_by_sources.blank?
     @revenue_by_sources =  @revenue_by_sources.paginate(page: params[:page],per_page: 10)
    end
  end

  # GET /revenue_by_sources/1
  # GET /revenue_by_sources/1.json
  def show
  end

  # GET /revenue_by_sources/new
  def new
    @revenue_by_source = RevenueBySource.new
  end

  # GET /revenue_by_sources/1/edit
  def edit
  end

  # POST /revenue_by_sources
  # POST /revenue_by_sources.json
  def create
    @revenue_by_source = RevenueBySource.new(revenue_by_source_params)

    respond_to do |format|
      if @revenue_by_source.save
        flash[:success] = 'Revenue by source was successfully created.'
        format.html { redirect_to revenue_by_sources_url}
        format.json { render :show, status: :created, location: @revenue_by_source }
      else
          format.html { redirect_to revenue_by_sources_url}
        format.json { render json: @revenue_by_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revenue_by_sources/1
  # PATCH/PUT /revenue_by_sources/1.json
  def update
    respond_to do |format|
      if @revenue_by_source.update(revenue_by_source_params)
        flash[:success] = 'Revenue by source was successfully updated.'
        format.html { redirect_to revenue_by_sources_url }
        format.json { render :show, status: :ok, location: @revenue_by_source }
      else
        format.html { redirect_to revenue_by_sources_url}
        format.json { render json: @revenue_by_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revenue_by_sources/1
  # DELETE /revenue_by_sources/1.json
  def destroy
    @revenue_by_source.destroy
    flash[:success] = 'Revenue by source was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to revenue_by_sources_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revenue_by_source
      @revenue_by_source = RevenueBySource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revenue_by_source_params
      params.require(:revenue_by_source).permit(:vote_number, :line_item, :July, :August, :September, :October, :November, :December, :January, :February, :March, :April, :May, :June)
    end
end
