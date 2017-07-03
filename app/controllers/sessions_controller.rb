class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
    redirect_to introduction_url if current_user #unless session[:user_id].blank?
  end

  def active
  end

  def timeout
  end

  def create
    company_code = params[:session][:company_code]
    set_up_database company_code unless params[:session][:company_code].blank?
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated? && (user.login_attempts < user.max_login_attempts) && !user.terminated?
        log_in user
        increment_login_count user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "Logged in sucessfully..."
        #redirect_back_or introduction_url
      else
        message  = 'Account terminated.please contact your system administrator.' if user.terminated?
        message  = 'Account not activated.Check your email for the activation link.' unless user.activated?
        message  = 'Account Locked.please contact your system administrator.' if account_locked?(user)
        flash[:danger] = message
        redirect_to root_url
      end
      redirect_to root_url
    else
      increment_login_attempts user unless user.blank?
      user.update_columns(status: 'Locked') unless user.blank?
      message = 'Invalid email/password combination.You have exceeded a maximum login attempts.your account has been locked.' if !user.blank? && (user.login_attempts >= user.max_login_attempts)
      message = 'wrong log on information provided...' if user
      flash[:danger] = message
      render 'new'
    end
  end

  def destroy
    note = 'User logged out of the system.'
    unless session[:user_id].blank?
      @user = current_user
      if @user && @user.update_columns(current_login_at: nil, current_login_ip: '', last_login: Time.zone.now, last_login_ip: request.env['REMOTE_ADDR'])
        note = 'user logged out of the system.'
        record_activity(note)
      end
      log_out if logged_in?
      flash[:success] = "Logged out sucessfully..."
    end
    redirect_to root_url
  end
end
