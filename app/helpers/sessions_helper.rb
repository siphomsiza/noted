module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
    session[:session_database] = $logged_in_database
    $current_session_db = session[:session_database]
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  def increment_login_count(user)
    user.update_columns(:current_login_at => Time.zone.now, :current_login_ip => request.env['REMOTE_ADDR'])
    user.increment!(:login_count)
    note = "user logged in to the system."
    record_activity(note)
  end
  def increment_login_attempts(user)
    user.increment!(:login_attempts)
  end
  #Connects user to database for a session
  def set_up_database(company_code)
    ActiveRecord::Base.clear_all_connections!
    if company_code == "MKH001"
      ActiveRecord::Base.establish_connection(DB1_CONF)
      $logged_in_database = DB1_CONF
      $municipality_info = MasterSetup.first
    end
    if company_code == "DEV001"
        ActiveRecord::Base.establish_connection(:production) if Rails.env.production?
        ActiveRecord::Base.establish_connection(:development) if Rails.env.development?
        $logged_in_database = :production if Rails.env.production?
        $logged_in_database = :development if Rails.env.development?
        $municipality_info = MasterSetup.first
    end
    if company_code == "SAK001"
      ActiveRecord::Base.establish_connection(DB2_CONF)
      $logged_in_database = DB2_CONF
      $municipality_info = MasterSetup.first
    end
    if company_code == "LPN001"
      ActiveRecord::Base.establish_connection(DB3_CONF)
      $logged_in_database = DB3_CONF
      $municipality_info = MasterSetup.first
    end
    if company_code != "MKH001" && company_code != "SAK001" && company_code != "DEV001" && company_code != "LPN001"
      ActiveRecord::Base.clear_all_connections!
    end
  end
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:session_database)
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(store_location || default)
    session.delete(:forwarding_url)
  end
  def account_locked?(user)
    user.login_attempts >= user.max_login_attempts
  end
  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
