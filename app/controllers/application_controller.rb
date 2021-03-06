class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # ...
  #auto_session_timeout 5.minutes
  #before_timedout_action
  include PublicActivity::StoreController
  hide_action :current_user
  protect_from_forgery with: :exception
  include SessionsHelper
  def record_activity(note)
    unless current_user.blank?
      @activity = ActivityLog.new
      @activity = current_user.activity_logs.build
      @activity.admin = current_user.admin || current_user.super_admin
      @activity.browser = request.env['HTTP_USER_AGENT']
      @activity.ip_address = request.env['REMOTE_ADDR']
      @activity.controller = controller_name
      @activity.action = action_name
      @activity.note = note
      @activity.params = params.inspect
      @activity.save
    end
  end

  def authenticate
    # redirect_to root_url if session[:session_key].nil?
  end

  # def reload_page
  #   redirect_to :back http.read_timeout = 500
  # end
  def weather_details
    @client = YahooWeather::Client.new
    begin
      @response = Timeout.timeout(5) do
        @client.fetch(1_582_504) unless @client.blank?
      end
      @doc = @response.doc unless @response.blank?
      @forecast = @doc['item']['forecast'] unless @doc.blank?
    rescue Net::ReadTimeout, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
           Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      puts e.message
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def admin_user
    # @admin_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # @admin_user = @admin_user.admin
  end

  protected

  # override before_timedout
  def before_timedout
    # your custom code here
  end
end
