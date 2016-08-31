class DepartmentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :edit, :update, :destroy,:show]
  before_action :admin_user,     only: [:new, :index, :edit, :update, :destroy,:show]
  before_action :set_department,     only: [:edit, :update, :destroy,:show]
  def new
  	 @department = Department.new
  end

  def index
    begin

        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
  rescue SocketError => e
    flash[:notice] = "received Exception #{e.message}"
    puts "received Exception #{e}"
  end
      @department = Department.new
  	   @departments = Department.includes(:subdepartments).paginate(page: params[:page],per_page: 10).order(id: :asc)
  end

  def show
    
  end

  def edit
    
  end
  def create
  	@department = Department.new(department_params)
  	if @department.save
      flash[:success] = 'Department was successfully created.'
  		redirect_to departments_path

      else
      redirect_to :back

  	end

  end

  def update
    @department = Department.find(params[:id])
      if @department.update(department_params)
        flash[:success] = 'Department was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Department was not updated.'
        redirect_to :back
      end

  end

  # DELETE /municipalities/1
  # DELETE /municipalities/1.json
  def destroy
    @department = Department.find(params[:id])
    @department.destroy
      flash[:success]='Department was successfully deleted.'
      redirect_to departments_path

  end


  private

   def set_department
      @department = Department.find(params[:id])
    end

  def department_params
  	params.require(:department).permit(:name, :tel_no, :fax_no, :subdepartments_attributes => [ :id,:name,:_destroy])

  end
#

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
      redirect_to(root_url) unless current_user.admin?  || current_user.super_admin?
    end

end
