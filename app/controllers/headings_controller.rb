class HeadingsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :update, :destroy]
  before_action :admin_user,   only: [:index,:show, :new, :edit, :update, :destroy]
  def index
    @heading = Heading.new
    @general_headings = Heading.where(category: 'General').paginate( page: params[:page],per_page: 17)
    @headings = Heading.all
    @departmental_headings = Heading.where(category: 'Departmental SDBIP').paginate( page: params[:page],per_page: 17)
    @toplayer_headings = Heading.where(category: 'Top Layer SDBIP').paginate( page: params[:page],per_page: 17)
    @monthlycashflow_headings = Heading.where(category: 'Monthly Cashflows').paginate( page: params[:page],per_page: 17)
    @capitalProjects_headings = Heading.where(category: 'Capital Projects').paginate( page: params[:page],per_page: 17)
    @revenuebysource_headings = Heading.where(category: 'Revenue by source').paginate( page: params[:page],per_page: 17)
  end

  def show
    @heading = Heading.find(params[:id])
  end

  def new
    @heading = Heading.new
  end

  def create
    @heading = Heading.new(heading_params)
    if @heading.save
      flash[:success] = "Heading was successfully created."
      redirect_to headings_path
    else
      render "new"
    end
  end

  def edit
    @heading = Heading.find(params[:id])
  end

  def update
    @heading = Heading.find(params[:id])

    if @heading.update_attributes(heading_params)
        flash[:success] = "Heading was successfully updated."
      redirect_to headings_path
    else
      render "edit"
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
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      # TO DO: Do this properly
      #redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
