class MasterSetupsController < ApplicationController
  before_action :set_master_setup, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :index, :edit, :update, :destroy,:show]
  before_action :admin_user,     only: [:new, :index, :edit, :update, :destroy,:show]
  # GET /master_setups
  # GET /master_setups.json
  def index
    begin

        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
      #@response = @client.fetch_by_location('New York')
      #@response.units.temperature
      #@response.condition.temp

  rescue SignalException => e
    flash[:notice] = "received Exception #{e.message}"
    puts "received Exception #{e}"
  end
    @jobtitle = Jobtitle.new
    @job_titles = Jobtitle.all
    @master_setup = MasterSetup.new
    @master_setups = MasterSetup.all
  end

  # GET /master_setups/1
  # GET /master_setups/1.json
  def show
  end

  # GET /master_setups/new
  def new
    @master_setup = MasterSetup.new
  end

  # GET /master_setups/1/edit
  def edit
  end

  # POST /master_setups
  # POST /master_setups.json
  def create
    @master_setup = MasterSetup.new(master_setup_params)
      if @master_setup.save
        flash[:success] = 'Location was successfully saved.'
        redirect_to master_setups_url
      else
        flash[:danger] = 'Location was not saved.'
        redirect_to master_setups_url
    end
  end

  # PATCH/PUT /master_setups/1
  # PATCH/PUT /master_setups/1.json
  def update

      if @master_setup.update(master_setup_params)
        flash[:success] = 'Location was successfully saved.'
        redirect_to master_setups_url

      else
        flash[:danger] = 'Location was not saved.'
        redirect_to master_setups_url
    end
  end

  # DELETE /master_setups/1
  # DELETE /master_setups/1.json
  def destroy
    @master_setup.destroy
    flash[:danger] =  'Master setup was successfully deleted.'
      redirect_to master_setups_url

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_setup
      @master_setup = MasterSetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_setup_params
      params.require(:master_setup).permit(:municipality,:province, :regions_attributes => [ :id,:name,:_destroy])
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
