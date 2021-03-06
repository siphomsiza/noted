class KpiOwnersController < ApplicationController
  before_action :set_kpi_owner, only: [:edit_kpi_owner_title,:show, :edit, :update, :destroy,:add_admin]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?

  # GET /kpi_owners/1
  # GET /kpi_owners/1.json
  def show
  end

  # GET /kpi_owners/new
  def new
    @kpi_owner = KpiOwner.new
  end
  def add_admin

  end
  # GET /kpi_owners/1/edit
  def edit_kpi_owner_title
  end
  def edit
  end

  # POST /kpi_owners
  # POST /kpi_owners.json
  def create
    @kpi_owner = KpiOwner.new(kpi_owner_params)

      if @kpi_owner.save
        flash[:success] = 'KPI Owner was successfully created.'
      else
        flash[:danger] = "KPI Owner was not created."
      end
      redirect_to :back
  end

  # PATCH/PUT /kpi_owners/1
  # PATCH/PUT /kpi_owners/1.json
  def update
      if @kpi_owner.update(kpi_owner_params)
        flash[:success] = 'KPI Owner was successfully saved.'
      else
        flash[:danger] = "KPI Owner was not saved."
      end
      redirect_to :back
  end

  # DELETE /kpi_owners/1
  # DELETE /kpi_owners/1.json
  def destroy
    @kpi_owner.destroy
      flash[:success] = 'KPI owner was successfully deleted.'
      redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_kpi_owner
      @kpi_owner = KpiOwner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kpi_owner_params
      params.require(:kpi_owner).permit(:name,:user_id,:can_update)
    end
end
