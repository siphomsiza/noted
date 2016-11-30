class DepartmentsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user,     only: [:index, :edit, :update, :destroy]
  before_action :set_department,     only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?
  def index
      weather_details
      @department = Department.new
  	   @departments = Department.includes(:subdepartments).paginate(page: params[:page],per_page: 10).order(id: :asc)
  end

  def edit
  end
  def create
  	@department = Department.new(department_params)
  	if @department.save
      flash[:success] = 'Department record was successfully created.'
      else
        flash[:danger] = 'Department record was not created.'
  	end
    redirect_to :back
  end

  def update
      if @department.update(department_params)
        flash[:success] = 'Department record was successfully updated.'
      else
        flash[:danger] = 'Department record was not updated.'
      end
      redirect_to :back
  end

  # DELETE /municipalities/1
  # DELETE /municipalities/1.json
  def destroy
    @department.destroy
      flash[:success]='Department record was successfully deleted.'
      redirect_to departments_path
  end


  private
  def js_request?
      request.format.js?
  end
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
