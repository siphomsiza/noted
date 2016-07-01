class DepartmentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :edit, :update, :destroy,:show]
  before_action :admin_user,     only: [:new, :index, :edit, :update, :destroy,:show]
  def new
  	@department = Department.new
  	 @users = User.all
  end

  def index
    @department = Department.new
  	@departments = Department.paginate( page: params[:page],per_page: 10)
  end

  def show
    @department = Department.find(params[:id])
  end

  def edit
    @department = Department.find(params[:id])
    @users = User.all
  end
  def create
    @users = User.all
  	@department = Department.new(department_params)
  	if @department.save
  		redirect_to departments_path

      else
      render :new

  	end

  end

  def update
    @users = User.all
    @department = Department.find(params[:id])
      if @department.update(department_params)
        flash[:success] = 'Department was successfully updated.'
        redirect_to :back
      else
        flash[:danger] = 'Department was not updated.'
        redirect_to :back
      end
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
  	params.require(:department).permit(:name, :tel_no, :fax_no, :subdepartments_attributes => [ :id,:subdepartment_name,:_destroy])

  end
#
    def set_user
      @user = User.find(params[:id])
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
      redirect_to(root_url) unless current_user.admin?
    end

end
