class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit,:set_super_user, :update, :destroy,:edit_new_user,:edit_active_user,:set_new_password]
  before_action :correct_user,   only: [:edit, :update,:show]
  before_action :admin_user,     only: [:edit, :update,:destroy,:index,:show,:edit_new_user,:edit_active_user]
  before_action :set_user, only: [:show, :edit, :update,:destroy,:deactivate,:set_admin,:set_normal_user,:terminate,:restore,:lock_user,:unlock_user,:activate,:edit_new_user,:edit_active_user,:edit_user_profile]

  def index
    begin

        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
      #@response = @client.fetch_by_location('New York')
      #@response.units.temperature
      #@response.condition.temp

  rescue SignalException => e
    flash[:notice] = "received Exception #{e.message}"
    puts "received Exception #{e}"
  end
      @system_users = User.all
      @user_activities = ActivityLog.where(admin: false).paginate(page: params[:page], per_page: 15)
      @super_user_activities = ActivityLog.where(admin: true).paginate(page: params[:page], per_page: 15)
      @user = User.new
      @users = @system_users.paginate(page: params[:page],per_page: 15).includes(:department)
      @admin_users = @system_users.where(admin: true).paginate( page: params[:page],per_page: 15)
      @active_users = @system_users.where(activated: true).paginate( page: params[:page],per_page: 15)
      @inactive_users = @system_users.where(activated: false).paginate( page: params[:page],per_page: 15)
      @terminated_users = @system_users.where(terminated: true).paginate(page: params[:page],per_page: 15)
      @new_users = @system_users.where(activated: false).paginate(page: params[:page],per_page: 15)
      @locked_users = @system_users.where("login_attempts >= max_login_attempts").paginate(page: params[:page],per_page: 15)
      @user_login_attempts = @system_users.where("login_count > ? OR login_attempts > ?", 0,0).paginate(page: params[:page],per_page: 15)

  end
  def set_new_password
    @user = User.find(current_user.id)
  end
  def show
    begin

        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
      #@response = @client.fetch_by_location('New York')
      #@response.units.temperature
      #@response.condition.temp

    rescue SignalException => e
      flash[:notice] = "received Exception #{e.message}"
      puts "received Exception #{e}"
    end
  end

  def set_super_user
    if params[:user_id] && !params[:user_id].blank?
      @user = User.find(params[:user_id])
      if @user.update_columns(super_admin: true)
        flash[:success] = "#{@user.firstname} #{@user.surname} set to super user/admin successfully."
        redirect_to users_path
      end
    else
      flash[:warning] = "failed to set #{@user.firstname} #{@user.surname} as super user/admin."
      redirect_to users_path
    end
  end

  def new
    @user = User.new
    if @user.update_columns(:new => true, :added_at => Time.zone.now,:status => "New")
      redirect_to users_path
    end

  end
  def edit_new_user

  end

def edit_active_user

end

def edit_user_profile

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

  end

  def update

    if @user.update_attributes(user_params)
      flash[:success] = "User details updated successfully"
      if admin_user && !correct_user
        redirect_to :back
      elsif !admin_user && correct_user
        redirect_to introduction_url
      end
    else
      flash[:danger] = "Profile not updated."
      redirect_to :back
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  def deactivate

    if @user.update_columns(:activated => false, :activated_at => Time.zone.now)
      flash[:success] = "#{@user.firstname} #{@user.surname}'s account deactivated successfully."
      redirect_to users_path
    end

  end

  def set_admin

    if @user.update_columns(:admin => true)
      flash[:success] = "#{@user.firstname}  #{@user.surname} set as System Administrator."
      redirect_to users_path
    else
      flash[:danger] = "Failed to set #{@user.firstname}  #{@user.surname} as System Administrator."
      redirect_to :back
    end
  end
  def set_maximum_attempts
    if params[:attempts] && !params[:attempts].blank?
      new_maximum_attempts = params[:attempts]
      new_maximum_attempts.to_i
      @users = User.all
      if @users.update_all(max_login_attempts: params[:new_maximum_attempts])
        flash[:success] = "Maximum login attempts updated successfully."
        redirect_to users_path
      end
    else
      flash[:warning] = "Maximum login attempts not updated."
      redirect_to users_path
    end
  end
  def set_normal_user

    if @user.update_columns(:admin => false)
      flash[:success] = "User removed as System Administrator successfully."
      redirect_to users_path
    else
      flash[:danger] = "Failed to remove #{@user.firstname}  #{@user.surname} as System Administrator."
      redirect_to :back
    end
  end
  def terminate

    if @user.update_columns(:terminated => true, :terminated_at => Time.zone.now,:status => "Terminated")
      flash[:success] = "Account terminated successfully."
      redirect_to users_path
    else
      flash[:danger] = "Failed to terminate #{@user.firstname}'s Account."
      redirect_to :back
    end

  end

    def restore

      if @user.update_columns(:terminated => false, :terminated_at => nil)
        redirect_to users_path
      end

    end
    def lock_user

      max_attempts = @user.max_login_attempts
      max_attempts.to_i
      max_attempts += 1
      if @user.update_columns(:login_attempts=>max_attempts, :activated=> false, :status => "Locked")
        @user.send_locked_account_email
        flash[:success] = "#{@user.firstname}'s account locked successfully."
        redirect_to users_path
      else
        flash[:danger] = "Failed to lock #{@user.firstname}'s account."
        redirect_to :back
      end

    end
    def unlock_user

      if @user.update_columns(:login_attempts=>0, :activated => true, :status => "Active")
        @user.send_unlocked_account_email
        flash[:success] = "Unlocked #{@user.firstname}'s account successfully."
        redirect_to users_path
      else
        flash[:danger] = "Failed to unlock #{@user.firstname}'s account."
        redirect_to :back
      end

    end
  def activate

    if @user.update_columns(:activated => true, :activated_at => Time.zone.now)
      flash[:success] = "Account deactivated successfully."
      redirect_to users_path
    end

  end

  private

    def user_params
      params.require(:user).permit(:title, :firstname, :surname, :id_number, :active_log,
      :user_name, :admin, :employee_number, :employee_date,:birth_date,:username,:id_number, :job_title, :department, :location, :manager,
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
