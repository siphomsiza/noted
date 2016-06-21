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


  # PATCH/PUT /municipalities/1
  # PATCH/PUT /municipalities/1.json
  def update
    @users = User.all
    @department = Department.find(params[:id])
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_path, success: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: departments_path}
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
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
