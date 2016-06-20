class ListsController < ApplicationController
def index
    @list = List.new
    @areas = Area.all
    @wards = Ward.all
  	@lists = List.all
  end

  def show
  	@list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      flash[:success] = "List was successfully created"
      redirect_to lists_path
    else
      render "new"
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
        @list = List.find(params[:id])

    if @list.update_attributes(list_params)
       flash[:success] = "List was successfully updated"
      redirect_to lists_path
    else
      render "edit"
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    flash[:success] = 'List was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to lists_path}
      format.json { head :no_content }
    end
  end

  private
    def list_params
        params.require(:list).permit(:name, :description, areas_attributes: [:name,
          :id,:_destroy,wards_attributes: [:name,:ward_no, :mun_ref,:area_id,:_destroy]],
        	funding_sources_attributes: [:name, :id,:_destroy],
        	mscore_classifications_attributes: [:name, :id,:_destroy],
          municipal_kpas_attributes: [:name, :code, :id,:_destroy],
          national_kpas_attributes: [:name, :code, :id,:_destroy],
        	kpi_concepts_attributes: [:name, :code, :id,:_destroy],
        	kpi_owners_attributes:[:name, :id,:_destroy],
        	kpi_types_attributes: [:name, :code, :id,:_destroy],
          risk_ratings_attributes: [:name, :code, :id,:_destroy],
        	kpas_attributes: [:name, :id,:_destroy],
        	national_outcomes_attributes: [:name, :id,:_destroy],
        	ndp_objectives_attributes: [:name, :id,:_destroy],
        	predetermined_objectives_attributes: [:name, :id,:_destroy],
        	provincial_strategic_outcomes_attributes: [:name, :id,:_destroy],
        	reporting_categories_attributes: [:name, :id,:_destroy],
        	strategic_objectives_attributes: [:name, :id,:_destroy],
        	kpi_calculation_types_attributes: [:name, :code, :description, :id,:_destroy],
        	kpi_target_types_attributes: [:name, :code, :id,:_destroy])
    end
end
