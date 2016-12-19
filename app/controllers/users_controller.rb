class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :set_super_user, :update, :destroy, :edit_new_user, :edit_active_user, :set_new_password,:report_users,:setup_users]
    before_action :correct_user,   only: [:edit, :update, :show]
    before_action :admin_user,     only: [:edit, :update, :destroy, :index, :show, :edit_new_user, :edit_active_user, :set_new_password,:report_users,:setup_users]
    before_action :set_user, only: [:show, :edit, :update, :destroy, :deactivate, :set_admin, :set_normal_user, :terminate, :restore, :lock_user, :unlock_user, :activate, :edit_new_user, :edit_active_user, :edit_user_profile]
    before_action :set_users, only: [:index, :report_users,:setup_users]

    def index
        weather_details
        @user_activities = ActivityLog.where(admin: false)#.paginate(page: params[:page], per_page: 15).includes(:user)
        @super_user_activities = ActivityLog.where(admin: true)#.paginate(page: params[:page], per_page: 15).includes(:user)
        @user = User.new
        @admin_users = User.where('admin = ? OR super_admin = ?', true, true)#.paginate(page: params[:page], per_page: 15)
        @active_users = User.where(activated: true)#.paginate(page: params[:page], per_page: 15).includes(:role)
        @inactive_users = User.where(activated: false)#.paginate(page: params[:page], per_page: 15)
        @terminated_users = User.where(terminated: true)#.paginate(page: params[:page], per_page: 15)
        @new_users = User.where(activated: false)#.paginate(page: params[:page], per_page: 15)
        @locked_users = User.where('login_attempts >= max_login_attempts')#.paginate(page: params[:page], per_page: 15)
        @user_login_attempts = User.where('login_count > ? OR login_attempts > ?', 0, 0)#.paginate(page: params[:page], per_page: 15)
        respond_to do |format|
          format.html
          format.json { render json: @active_users}
          format.js
        end
    end
    def report_users
      weather_details
      @user_activities = ActivityLog.where(admin: false)#.paginate(page: params[:page], per_page: 15).includes(:user)
      @super_user_activities = ActivityLog.where(admin: true)#.paginate(page: params[:page], per_page: 15).includes(:user)
      @user_login_attempts = User.where('login_count > ? OR login_attempts > ?', 0, 0)#.paginate(page: params[:page], per_page: 15)
    end
    def setup_users
      weather_details
    end
    def set_new_password
        @user = User.find(current_user.id)
    end

    def show
        weather_details
    end

    def set_super_user
        if params[:user_id] && !params[:user_id].blank?
            @user = User.find(params[:user_id])
            if @user.update_columns(super_admin: true)
                flash[:success] = "User set to super user/admin successfully."
            end
        else
            flash[:danger] = "failed to set #{@user.firstname} #{@user.surname} as super user/admin."
        end
        redirect_to :back
    end

    def new
        @user = User.new
        @system_users = User.all
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
          @user.update_columns(updated_at: Time.zone.now,created_at: Time.zone.now, status: 'New')
            @user.send_activation_email
            flash[:info] = 'Please check your email to confirm your account.'
        else
            flash[:danger] = 'Failed to add new user. Please complete properly the fields below.'
        end
        redirect_to :back
    end

    def edit
      respond_to do |format|
        format.html
        format.js
      end
    end

    def update
        if @user.update_attributes(user_params)
            flash[:success] = 'User details updated successfully'
        else
            flash[:danger] = 'Profile not updated.'
        end
          redirect_to :back
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = 'User deleted'
        redirect_to users_path
    end

    def deactivate
        if @user.update_columns(activated: false, activated_at: Time.zone.now)
            flash[:success] = "#{@user.firstname} #{@user.surname}'s account deactivated successfully."
        end
        redirect_to :back
    end

    def set_admin
        if @user.update_columns(admin: true)
            flash[:success] = "User set as System Administrator."
        else
            flash[:danger] = "Failed to set User as System Administrator."
        end
        redirect_to :back
    end

    def set_maximum_attempts
        if params[:attempts] && !params[:attempts].blank?
            new_maximum_attempts = params[:attempts]
            new_maximum_attempts.to_i
            @users = User.all
            if @users.update_all(max_login_attempts: new_maximum_attempts)
                flash[:success] = 'Maximum login attempts updated successfully.'
            end
        else
            flash[:danger] = 'Maximum login attempts not updated.'
        end
        redirect_to :back
    end

    def set_normal_user
        if @user.update_columns(admin: false)
            flash[:success] = 'User removed as System Administrator successfully.'
        else
            flash[:danger] = "Failed to remove user as System Administrator."
        end
        redirect_to :back
    end

    def terminate
        if @user.update_columns(terminated: true, terminated_at: Time.zone.now, status: 'Terminated')
            flash[:success] = 'Account terminated successfully.'
        else
            flash[:danger] = "Failed to terminate #{@user.firstname}'s Account."
        end
        redirect_to :back
    end

    def restore
        if @user.update_columns(terminated: false, terminated_at: nil)
        end
        redirect_to :back
    end

    def lock_user
        max_attempts = @user.max_login_attempts
        max_attempts.to_i
        max_attempts += 1
        if @user.update_columns(login_attempts: max_attempts, status: 'Locked')
            @user.send_locked_account_email
            flash[:success] = "User's account locked successfully."
        else
            flash[:danger] = "Failed to lock #{@user.firstname}'s account."
        end
        redirect_to :back
    end

    def unlock_user
        if @user.update_columns(login_attempts: 0, status: 'Active')
            @user.send_unlocked_account_email
            flash[:success] = "Unlocked User's account successfully."
        else
            flash[:danger] = "Failed to unlock #{@user.firstname}'s account."
        end
        redirect_to :back
    end

    def activate
        if @user
          @user.activate
          flash[:success] = 'Account activated successfully.'
        end
        redirect_to :back
    end

    private

    def user_params
        params.require(:user).permit(:title, :firstname, :surname, :id_number, :active_log,
                                     :user_name, :admin, :employee_number, :employee_date, :birth_date, :username, :id_number, :job_title, :department, :location, :manager,
                                     :country_prefix, :landline, :mobile, :fax, :gender, :race, :occupational_category,
                                     :disabled, :birthday, :email, :password,
                                     :password_confirmation, :avatar, roles_attributes: [:name, :description, :edit_right, :delete_right, :create_right, :approve_right, :view_right, :deactivate_right, :update_right, :user_id])
    end

    #
    def set_user
        @user = User.find(params[:id])
    end
    def set_users
        @users = User.all.includes(:department).includes(:role)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = 'Please log in.'
            redirect_to login_url
        end
    end

    # Confirms the correct user.
    def correct_user
        # TO DO: Do this properly
        # redirect_to(root_url) unless
        current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
        redirect_to(root_url) unless current_user.admin? || correct_user || current_user.super_admin?
    end
end
