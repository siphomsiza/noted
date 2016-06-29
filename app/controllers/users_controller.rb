class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,:edit_new_user,:edit_active_user]
  before_action :correct_user,   only: [:edit, :update,:show]
  before_action :admin_user,     only: [:edit, :update,:destroy,:index,:show,:edit_new_user,:edit_active_user]

  def index

      @roles = Role.paginate(page: params[:page],per_page: 15)
      @user_activities = ActivityLog.where(admin: false).paginate(page: params[:page], per_page: 15)
      @super_user_activities = ActivityLog.where(admin: true).paginate(page: params[:page], per_page: 15)
      @user = User.new
      @users = User.paginate(page: params[:page],per_page: 15)
      @admin_users = User.where(admin: true).paginate( page: params[:page],per_page: 15)
      @active_users = User.where(activated: true).paginate( page: params[:page],per_page: 15)
      @inactive_users = User.where(activated: false).paginate( page: params[:page],per_page: 15)
      @terminated_users = User.where(terminated: true).paginate(page: params[:page],per_page: 15)
      @new_users = User.where(activated: false).paginate(page: params[:page],per_page: 15)
      @locked_users = User.where("login_attempts >= max_login_attempts").paginate(page: params[:page],per_page: 15)
      @user_login_attempts = User.where("login_count > ? OR login_attempts > ?", 0,0).paginate(page: params[:page],per_page: 15)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    if @user.update_columns(:new => true, :added_at => Time.zone.now,:status => "new")
      redirect_to users_path
    end

  end
  def edit_new_user
  @user = User.find(params[:id])
  respond_to do |format|
    format.html
    format.js
  end
end

def edit_active_user
  @user = User.find(params[:id])
  respond_to do |format|
    format.html
    format.js
  end
end

def edit_user_profile
  @user = User.find(params[:id])
  respond_to do |format|
    format.html
    format.js
  end
end

def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to confirm your account."
      redirect_to users_url
    else
      flash[:danger] = "Failed to add new user. Please complete properly the fields below."
      redirect_to users_url
    end
end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      if admin_user && !correct_user
        redirect_to users_url
      elsif !admin_user && correct_user

      end
    else
      flash[:success] = "Profile not updated."
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  def deactivate
    #@user = User.find(params[:user_id])
    #if @user.update_attribute(:activated, false) && @user.update_attribute(:activated_at, Time.zone.now)
    # redirect_to users_path, flash[:success] = "Account deactivated successfully."
    #else
    #end
    @user = User.find(params[:id])
    if @user.update_columns(:activated => false, :activated_at => Time.zone.now)
      flash[:success] = "Account deactivated successfully."
      redirect_to users_path
    end

  end

  def set_admin
    @user = User.find(params[:id])
    if @user.update_columns(:admin => true)
      redirect_to users_path
    end
  end
  def set_maximum_attempts
    if params[:attempts] && !params[:attempts].blank?
      new_maximum_attempts = params[:attempts]
      new_maximum_attempts.to_i
      @users = User.all
      if @users.update_all(max_login_attempts: new_maximum_attempts)
        flash[:success] = "Maximum login attempts updated successfully."
        redirect_to users_path
      end
    else
      flash[:warning] = "Maximum login attempts not updated."
      redirect_to users_path
    end
  end
  def set_normal_user
    @user = User.find(params[:id])
    if @user.update_columns(:admin => false)
      redirect_to users_path
    end
  end
  def terminate
    @user = User.find(params[:id])
    if @user.update_columns(:terminated => true, :terminated_at => Time.zone.now,:status => "terminated")
      flash[:success] = "Account terminated successfully."
      redirect_to users_path
    end

  end

    def restore
      @user = User.find(params[:id])
      if @user.update_columns(:terminated => false, :terminated_at => nil)
        redirect_to users_path
      end

    end
    def lock_user
      @user = User.find(params[:id])
      max_attempts = @user.max_login_attempts
      max_attempts.to_i
      max_attempts += 1
      if @user.update_columns(:login_attempts=>max_attempts, :status => "Locked")
        flash[:success] = "Account locked successfully."
        redirect_to users_path
      end

    end
    def unlock_user
      @user = User.find(params[:id])
      if @user.update_columns(:login_attempts=>0, :status => "Active")
        redirect_to users_path
      end

    end
  def activate
    @user = User.find(params[:id])
    if @user.update_columns(:activated => true, :activated_at => Time.zone.now)
      flash[:success] = "Account deactivated successfully."
      redirect_to users_path
    end

  end

  private

    def user_params
      params.require(:user).permit(:title, :firstname, :surname, :id_number, :active_log,
      :user_name, :employee_number, :employee_date, :job_title, :department, :location, :manager,
      :country_prefix, :landline, :mobile, :fax, :gender, :race, :occupational_category,
      :disabled, :birthday, :email, :password,
                                   :password_confirmation, :roles_attributes=>[:name, :description, :edit_right,:delete_right,:create_right,:approve_right,:view_right,:deactivate_right,:update_right,:user_id])
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

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      # TO DO: Do this properly
      #redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin? || correct_user
    end
end
