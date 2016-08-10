class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.includes(:wards)
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

      if @area.save
        flash[:success] = 'Area was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Area was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update

      if @area.update(area_params)
        flash[:success] = 'Area was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Area was not updated.'
        redirect_to :back
      end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    flash[:notice] = 'Area was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name,:wards_attributes => [ :id,:name,:ward_no,:mun_ref,:_destroy])
    end
end
