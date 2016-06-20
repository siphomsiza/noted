class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  after_filter :record_activity

# ...
  hide_action :current_user
  protect_from_forgery with: :exception
  include SessionsHelper

  def record_activity
    if !current_user.blank?
    note = "User logged in to the system."
    @activity = ActivityLog.new
    @activity.note = note
    @activity.user_id = current_user.id
    #@activity.admin = current_user.admin
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.ip_address = request.env['REMOTE_ADDR']
    @activity.controller = controller_name
    @activity.action = action_name
    @activity.params = params.inspect
    @activity.save
    end
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
