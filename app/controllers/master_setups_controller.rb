class MasterSetupsController < ApplicationController
  before_action :set_master_setup, only: [:show, :edit, :update, :destroy]

  # GET /master_setups
  # GET /master_setups.json
  def index
      @jobtitle = Jobtitle.new
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

    respond_to do |format|
      if @master_setup.save
        flash[:success] = 'Master setup was successfully created.'
        format.html { redirect_to master_setups_url}
        format.json { render :show, status: :created, location: master_setups_url }
      else
        flash[:danger] = 'Master setup was not created.'
        format.html { redirect_to master_setups_url}
        format.json { render :show, status: :created, location: master_setups_url }
      end
    end
  end

  # PATCH/PUT /master_setups/1
  # PATCH/PUT /master_setups/1.json
  def update
    respond_to do |format|
      if @master_setup.update(master_setup_params)
        flash[:success] = 'Master setup was successfully updated.'
        format.html { redirect_to master_setups_url}
        format.json { render :show, status: :created, location: master_setups_url }
      else
        flash[:danger] = 'Master setup was not updated.'
        format.html { redirect_to master_setups_url}
        format.json { render :show, status: :created, location: master_setups_url }
      end
    end
  end

  # DELETE /master_setups/1
  # DELETE /master_setups/1.json
  def destroy
    @master_setup.destroy
    flash[:danger] =  'Master setup was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to master_setups_url }
      format.json { head :no_content }
    end
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
end
