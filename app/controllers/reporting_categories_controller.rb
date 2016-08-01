class ReportingCategoriesController < ApplicationController
  before_action :set_reporting_category, only: [:show, :edit, :update, :destroy]

  # GET /reporting_categories
  # GET /reporting_categories.json
  def index
    @reporting_categories = ReportingCategory.all
  end

  # GET /reporting_categories/1
  # GET /reporting_categories/1.json
  def show
  end

  # GET /reporting_categories/new
  def new
    @reporting_category = ReportingCategory.new
  end

  # GET /reporting_categories/1/edit
  def edit
  end

  # POST /reporting_categories
  # POST /reporting_categories.json
  def create
    @reporting_category = ReportingCategory.new(reporting_category_params)

      if @reporting_category.save
        flash[:success] = 'Reporting Category was successfully created.'
        redirect_to :back
      else
        flash[:danger] = 'Reporting Category was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /reporting_categories/1
  # PATCH/PUT /reporting_categories/1.json
  def update

      if @reporting_category.update(reporting_category_params)
        flash[:success] = 'Reporting Category was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Reporting Category was not updated.'
        redirect_to :back
      end
  end

  # DELETE /reporting_categories/1
  # DELETE /reporting_categories/1.json
  def destroy
    @reporting_category.destroy
    flash[:success] = 'Reporting Category was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reporting_category
      @reporting_category = ReportingCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reporting_category_params
      params.require(:reporting_category).permit(:name)
    end
end
