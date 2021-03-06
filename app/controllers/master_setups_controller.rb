class MasterSetupsController < ApplicationController
  before_action :set_master_setup, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show_image,:new, :index, :edit, :update, :destroy,:show]
  before_action :admin_user,     only: [:new, :index, :edit, :update, :destroy,:show]
  # GET /master_setups
  # GET /master_setups.json
  def index

    weather_details
    @jobtitle = Jobtitle.new
    @areas = Area.all
    @job_titles = Jobtitle.paginate(page: params[:page],per_page: 15)
    @master_setup = MasterSetup.new
    @master_setups = MasterSetup.limit(1).order(id: :asc)
    @setup = MasterSetup.find_by(:id=>1)
  end

  # GET /master_setups/1
  # GET /master_setups/1.json
  def show
  end

  # GET /master_setups/1/edit
  def edit
  end

  # POST /master_setups
  # POST /master_setups.json
  def create
    @master_setup = MasterSetup.new(master_setup_params)
      if @master_setup.save
        flash[:success] = 'Master setup was successfully saved.'
        redirect_to :back
      else
        flash[:danger] = 'Master setup was not saved.'
        redirect_to :back
    end
  end

  # PATCH/PUT /master_setups/1
  # PATCH/PUT /master_setups/1.json
  def update

      if @master_setup.update(master_setup_params)
        flash[:success] = 'Master setup was successfully saved.'
        redirect_to :back

      else
        flash[:danger] = 'Master setup was not saved.'
        redirect_to :back
    end
  end

  # DELETE /master_setups/1
  # DELETE /master_setups/1.json
  def destroy
    @master_setup.destroy
    flash[:success] =  'Master setup was successfully deleted.'
    redirect_to :back

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_setup
      @master_setup = MasterSetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_setup_params
      params.require(:master_setup).permit(:municipality,:logo,:address,:province, :latitude,:longitude)
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
      redirect_to(root_url) unless current_user.admin? || current_user.super_admin?
    end
end
