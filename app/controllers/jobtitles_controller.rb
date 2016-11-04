class JobtitlesController < ApplicationController
  before_action :set_jobtitle, only: [:show, :edit, :update, :destroy]

  # GET /jobtitles
  # GET /jobtitles.json
  def index
    @jobtitles = Jobtitle.all
  end

  # GET /jobtitles/1
  # GET /jobtitles/1.json
  def show
  end

  # GET /jobtitles/new
  def new
    @jobtitle = Jobtitle.new
  end

  # GET /jobtitles/1/edit
  def edit
  end

  # POST /jobtitles
  # POST /jobtitles.json
  def create
    @jobtitle = Jobtitle.new(jobtitle_params)

    respond_to do |format|
      if @jobtitle.save
        flash[:success] = 'Jobtitle was successfully created.'
        format.html { redirect_to :back }
        format.json { render :show, status: :created, location: master_setups_path }
      else
        flash[:danger] = 'Jobtitle was not created.'
        format.html { redirect_to :back }
        format.json { render json: @jobtitle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobtitles/1
  # PATCH/PUT /jobtitles/1.json
  def update
    respond_to do |format|
      if @jobtitle.update(jobtitle_params)
        flash[:success] = 'Jobtitle was successfully updated.'
        format.html { redirect_to :back }
        format.json { render :show, status: :ok, location: master_setups_path }
      else
        flash[:success] = 'Jobtitle was not updated.'
        format.html { redirect_to :back }
        format.json { render :show, status: :ok, location: master_setups_path }
      end
    end
  end

  # DELETE /jobtitles/1
  # DELETE /jobtitles/1.json
  def destroy
    @jobtitle.destroy
    respond_to do |format|
      flash[:success] = 'Jobtitle was successfully deleted.'
      format.html { redirect_to :back }
      format.json { render :show, status: :ok, location: master_setups_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jobtitle
      @jobtitle = Jobtitle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jobtitle_params
      params.require(:jobtitle).permit(:title)
    end
end
