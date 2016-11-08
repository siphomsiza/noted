class TopLayerSdbipsController < ApplicationController
  before_action :set_top_layer_sdbip, only: [:show, :edit, :edit_top_layer_sdbips,:update, :destroy]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy,:edit_top_layer_sdbips]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy,:edit_top_layer_sdbips]

  # GET /top_layer_sdbips
  # GET /top_layer_sdbips.json
  def index
    begin

        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
  rescue SocketError => e
    flash[:danger] = "received Exception #{e.message}"
  end
    @top_layer_sdbip = TopLayerSdbip.new
    @top_layer_sdbips = TopLayerSdbip.paginate(page: params[:page],per_page: 10)
    
  end

  # GET /top_layer_sdbips/1
  # GET /top_layer_sdbips/1.json
  def show
  end
  def import
    if params[:file].nil?
       flash[:danger] = 'You have not selected a file'
      redirect_to top_layer_sdbips_url
    else
    begin
       CapitalProject.import(params[:file])
       flash[:success] = "Top Layer SDBIPs imported successfully."
       redirect_to top_layer_sdbips_url
    rescue=> e

       Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
       flash[:danger] = "Top Layer SDBIPs failed to import #{e.message}."
       redirect_to top_layer_sdbips_url
    end
  end
  end
  # GET /top_layer_sdbips/new
  def new
    @top_layer_sdbip = TopLayerSdbip.new
  end

  # GET /top_layer_sdbips/1/edit
  def edit
  end

  def edit_top_layer_sdbips
  end

  # POST /top_layer_sdbips
  # POST /top_layer_sdbips.json
  def create
    @top_layer_sdbip = TopLayerSdbip.new(top_layer_sdbip_params)

      if @top_layer_sdbip.save
        flash[:success] = 'Top layer sdbip was successfully created.'
        redirect_to top_layer_sdbips_url

      else
        flash[:danger] = 'Top layer sdbip was not created.'
        redirect_to top_layer_sdbips_url
    end
  end

  # PATCH/PUT /top_layer_sdbips/1
  # PATCH/PUT /top_layer_sdbips/1.json
  def update

      if @top_layer_sdbip.update(top_layer_sdbip_params)
        flash[:success] = 'Top layer sdbip was successfully updated.'
        redirect_to top_layer_sdbips_url

      else
        flash[:danger] = 'Top layer sdbip was not updated.'
        redirect_to top_layer_sdbips_url

    end
  end

  # DELETE /top_layer_sdbips/1
  # DELETE /top_layer_sdbips/1.json
  def destroy
    @top_layer_sdbip.destroy
    flash[:success] = 'Top layer sdbip was successfully deleted.'
      redirect_to top_layer_sdbips_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_top_layer_sdbip
      @top_layer_sdbip = TopLayerSdbip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def top_layer_sdbip_params
      params.require(:top_layer_sdbip).permit(:department_id, :reporting_kpi, :idp_ref, :mscore_classification_id, :national_outcome_id, :kpa_id, :predetermined_objective_id, :ndp_objective_id, :strategic_objective_id, :kpi, :unit_of_measurement, :risk, :ward_id, :area_id, :kpi_owner_id, :baseline, :poe, :past_year_performance, :mtas_indicator_id, :reporting_category, :kpi_calculation_type_id, :kpi_target_type_id, :annual_target, :revised_target, :first_quarter_target, :second_quarter_target, :third_quarter_target, :fourth_quarter_target, :first_quarter_actual, :second_quarter_actual, :third_quarter_actual, :fourth_quarter_actual)
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
