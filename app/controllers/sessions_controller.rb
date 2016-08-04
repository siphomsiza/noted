class SessionsController < ApplicationController
  def new
    redirect_to introduction_url unless !session[:user_id]
  end

  def create
    company_code = MasterSetup.find_by(company_code: params[:session][:company_code])
    #if !company_code.blank?
    #  establish_connection "development"
    #else
    #  flash[:danger] = "Wrong information provided..."
    #  redirect_to(:back) and return
    #end
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated? && !user.terminated? && user.login_attempts < user.max_login_attempts
        log_in user
            @user = current_user
            if @user.update_columns(:current_login_at => Time.zone.now, :current_login_ip => request.env['REMOTE_ADDR'])
                @user.increment!(:login_count)
                note = "user logged in to the system."
                record_activity(note)
            end
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or introduction_url

      elsif !user.activated?
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url

      elsif (!user.activated? || user.activated?) && user.terminated?
        message  = "Account terminated. "
        message += "please contact your system administrator."
        flash[:warning] = message
        redirect_to root_url
      elsif (user.login_attempts >= user.max_login_attempts)
        message  = "Account Locked. "
        message += "please contact your system administrator."
        flash[:danger] = message
        redirect_to root_url
      else

      end
    else

      @user = User.find_by(email: params[:session][:email].downcase)
      if !@user.blank? && !(@user.login_attempts >= @user.max_login_attempts)
          @user.increment!(:login_attempts)
          if @user.login_attempts >= @user.max_login_attempts
              @user.update_columns(:status=> "Locked")
              message  = "Invalid email/password combination."
              message  += "You have exceeded a maximum login attempts. "
              message += "your account has been locked."
              flash[:danger] = message

          else

          end

        elsif !@user.blank? && @user.login_attempts >= @user.max_login_attempts
              @user.increment!(:login_attempts)
              @user.update_columns(:status=> "Locked")
              message = "Your account has been locked."
              message += "please contact your system administrator.."
              flash[:danger] = message
        else

      end
      render 'new'
    end
  end

  def destroy
    note = "User logged out of the system."
    #record_activity
    if session[:user_id]
      @user = current_user
      if @user.update_columns(:current_login_at => nil,:current_login_ip=> "",:last_login => Time.zone.now,:last_login_ip => request.env['REMOTE_ADDR'])
        note = "user logged out of the system."
        record_activity(note)
      end
      log_out if logged_in?
    end
    redirect_to root_url

  end
end
