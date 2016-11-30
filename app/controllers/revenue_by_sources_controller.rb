class RevenueBySourcesController < ApplicationController
  before_action :set_revenue_by_source, only: [:show, :edit, :update, :destroy,:edit_revenue_by_sources]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy,:edit_revenue_by_sources]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy,:edit_revenue_by_sources]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?

  # GET /revenue_by_sources
  # GET /revenue_by_sources.json
  def index
    weather_details
    @revenue_by_source = RevenueBySource.new
    @revenue_by_sources = RevenueBySource.paginate(page: params[:page],per_page: 10)

  end

  # GET /revenue_by_sources/1
  # GET /revenue_by_sources/1.json
  def show
  end

  # GET /revenue_by_sources/1/edit
  def edit
  end

  def edit_revenue_by_sources
  end

  # POST /revenue_by_sources
  # POST /revenue_by_sources.json
  def create
    @revenue_by_source = RevenueBySource.new(revenue_by_source_params)

      if @revenue_by_source.save
        flash[:success] = 'Revenue by source was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Revenue by source was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /revenue_by_sources/1
  # PATCH/PUT /revenue_by_sources/1.json
  def update
      if @revenue_by_source.update(revenue_by_source_params)
        flash[:success] = 'Revenue by source was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Revenue by source was not updated.'
        redirect_to :back
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
    def js_request?
        request.format.js?
    end
    def set_revenue_by_source
      @revenue_by_source = RevenueBySource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revenue_by_source_params
      params.require(:revenue_by_source).permit(:vote_number, :line_item, :July, :August, :September, :October, :November, :December, :January, :February, :March, :April, :May, :June)
    end

    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end

      # Confirms an admin user.
      def admin_user
        #redirect_to(root_url) unless
        current_user.admin?
      end
end
