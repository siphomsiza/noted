class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

# ...
  include PublicActivity::StoreController
  hide_action :current_user
  protect_from_forgery with: :exception
  include SessionsHelper
  $municipality_info = MasterSetup.first
  def record_activity(note)
    if !current_user.blank?
      @activity = ActivityLog.new
      @activity.user_id = current_user.id
      @activity.admin = current_user.admin
      @activity.browser = request.env['HTTP_USER_AGENT']
      @activity.ip_address = request.env['REMOTE_ADDR']
      @activity.controller = controller_name
      @activity.action = action_name
      @activity.note = note
      @activity.params = params.inspect
      @activity.save
    end
  end
  def audit_log(departmental_sdbip_id)

    if !current_user.blank?
      @audit_log = Activity.new
      @audit_log.user_id = current_user.id
      @audit_log.browser = request.env['HTTP_USER_AGENT']
      @audit_log.ip_address = request.env['REMOTE_ADDR']
      @audit_log.params = params.inspect
      @audit_log.departmental_sdbip_id = departmental_sdbip_id
      @audit_log.save
    end
  end
  def authenticate
   redirect_to root_url if session[:session_key].nil?
 end
  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def admin_user
    #@admin_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    #@admin_user = @admin_user.admin
  end

end
