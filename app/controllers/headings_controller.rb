class HeadingsController < ApplicationController
  before_action :set_heading, only: [:edit_top_layer_headings,:edit_capital_projects_headings,:edit_revenue_by_source_headings,:edit_monthly_cashflow_headings,:edit_departmental_headings,:edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :update, :destroy,:edit_departmental_headings,:edit_top_layer_headings,:edit_capital_projects_headings,:edit_revenue_by_source_headings,:edit_monthly_cashflow_headings]
  before_action :admin_user,   only: [:index,:show, :new, :edit, :update, :destroy,:edit_departmental_headings,:edit_top_layer_headings,:edit_capital_projects_headings,:edit_revenue_by_source_headings,:edit_monthly_cashflow_headings]
  def index
    weather_details
    @general_headings = Heading.where(category: 'General').paginate( page: params[:page],per_page: 17)
    @headings = Heading.all
    @departmental_headings = @headings.where(category: 'Departmental SDBIP').paginate( page: params[:page],per_page: 17)
    @toplayer_headings = @headings.where(category: 'Top Layer SDBIP').paginate( page: params[:page],per_page: 17)
    @monthlycashflow_headings = @headings.where(category: 'Monthly Cashflows').paginate( page: params[:page],per_page: 17)
    @capitalProjects_headings = @headings.where(category: 'Capital Projects').paginate( page: params[:page],per_page: 17)
    @revenuebysource_headings = @headings.where(category: 'Revenue by source').paginate( page: params[:page],per_page: 17)
  end

  def show
  end

  def new
    @heading = Heading.new
  end

  def create
    @heading = Heading.new(heading_params)
    if @heading.save
      flash[:success] = "Heading was successfully created."
      redirect_to headings_path
    end
  end

  def edit
  end
  def edit_departmental_headings
    respond_to do |format|
      format.html
      format.js
    end
  end
  def edit_top_layer_headings
    respond_to do |format|
      format.html
      format.js
    end
  end
  def edit_capital_projects_headings
    respond_to do |format|
      format.html
      format.js
    end
  end
  def edit_revenue_by_source_headings
    respond_to do |format|
      format.html
      format.js
    end
  end
  def edit_monthly_cashflow_headings
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @heading.update_attributes(heading_params)
        flash[:success] = "Heading was successfully updated."
      redirect_to headings_path
    end
  end

  def destroy
     @heading = Heading.find(params[:id])
     @heading.destroy
     flash[:success] = "Heading was successfully deleted."
     redirect_to headings_path
  end

  private
    def heading_params
        params.require(:heading).permit(:term, :description, :category)
    end
    def set_heading
      @heading = Heading.find(params[:id])
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
