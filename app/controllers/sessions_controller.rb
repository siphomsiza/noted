class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new
    redirect_to introduction_url unless !session[:user_id]
  end

  def create
    company_code = params[:session][:company_code]
    set_up_database company_code if !params[:session][:company_code].blank?
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        if user.login_attempts < user.max_login_attempts
          if !user.terminated?
            log_in user
            increment_login_count user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or introduction_url
          else
            message  = "Account terminated. "
            message += "please contact your system administrator."
            flash[:danger] = message
            redirect_to(root_url) and return
          end
        else
          message  = "Account Locked. "
          message += "please contact your system administrator."
          flash[:danger] = message
          redirect_to(root_url) and return
        end
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:danger] = message
        redirect_to(root_url) and return
      end
    else
      @user = User.find_by(email: params[:session][:email].downcase)
      if !@user.blank? && !(@user.login_attempts >= @user.max_login_attempts)
          increment_login_attempts @user
          if @user.login_attempts >= @user.max_login_attempts
              @user.update_columns(:status=> "Locked")
              message  = "Invalid email/password combination."
              message  += "You have exceeded a maximum login attempts. "
              message += "your account has been locked."
              flash[:danger] = message
          end
          redirect_to(root_url) and return
      end
      if !@user.blank? && @user.login_attempts >= @user.max_login_attempts
              increment_login_attempts @user
              message = "Your account has been locked."
              message += "please contact your system administrator.."
              flash[:danger] = message
      else
          message = "wrong log on information provided..."
          flash[:danger] = message
      end
      redirect_to(root_url) and return
    end
  end

  def destroy
    note = "User logged out of the system."
    if session[:user_id]
      @user = current_user
      if @user.update_columns(:current_login_at => nil,:current_login_ip=> "",:last_login => Time.zone.now,:last_login_ip => request.env['REMOTE_ADDR'])
        note = "user logged out of the system."
        #record_activity(note)
      end
      log_out if logged_in?
    end
    redirect_to root_url
  end
end
