class PagesController < ApplicationController
  before_action :logged_in_user, only: [:about,:new,:setup,:dashboard,:introduction]
  before_action :admin_user,     only: [:about,:new,:setup,:dashboard]
  before_action :top_layer_administrator,     only: [:dashboard]

  def help
  end

  def about
    begin
        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
   rescue SocketError => e
    flash[:danger] = "received Exception #{e.message}"
    end
  end
  def introduction
    begin
        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
    rescue SocketError => e
    flash[:danger] = "received Exception #{e.message}"
    end
    @closed_primary = SdbipTimePeriod.where("extract(day from primary_closure) = ? AND extract(month from primary_closure) = ? AND extract(year from primary_closure) = ? AND primary_status = ?",Date.today.day,Date.today.month,Date.today.year,true)
    @closed_secondary = SdbipTimePeriod.where("extract(day from secondary_closure) = ? AND extract(month from secondary_closure) = ? AND extract(year from secondary_closure) = ? AND secondary_status = ?",Date.today.day,Date.today.month,Date.today.year,true)
    @primary_reminders = SdbipTimePeriod.where("extract(day from primary_reminder) = ? AND extract(month from primary_reminder) = ? AND extract(year from primary_reminder) = ? AND primary_status = ? AND primary_notification_sent = ?",Date.today.day,Date.today.month,Date.today.year,true,false)
    @secondary_reminders = SdbipTimePeriod.where("extract(day from secondary_reminder) = ? AND extract(month from secondary_reminder) = ? AND extract(year from secondary_reminder) = ? AND secondary_status = ? AND secondary_notification_sent = ? ", Date.today.day,Date.today.month,Date.today.year,true,false)
  end
  def contact
  end

  def setup

  end
  def dashboard
    @sdbip_time_periods = SdbipTimePeriod.where(["period >= ? AND period <= ?",Date.today,Date.today.days_ago(-7)])
    @users = User.all
    @departmental_sdbips = DepartmentalSdbip.order(performance_standard: :asc)
    @departmental_sdbips_kpa = DepartmentalSdbip.all
    @departments_sdibps = DepartmentalSdbip.select(:performance_standard).order(performance_standard: :asc).uniq
    @departments = Department.all
    $colors = []
    $colors = DepartmentalSdbip.chart_theme @departments_sdibps
    @colours = $colors
    begin
        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
    rescue SocketError => e
      flash[:danger] = "received Exception #{e.message}"
    end

  end
  private
  #

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
    def top_layer_administrator
      redirect_to(root_url) unless (!current_user.role.blank? && (current_user.role.top_layer_administrator? || current_user.role.assurance_provider? || current_user.role.audit_log_reporting? || current_user.role.secondary_time_period? )) || current_user.admin? || current_user.super_admin?
    end
    # Confirms an admin user.
    def admin_user
      #redirect_to(root_url) unless
      current_user.admin || current_user.super_admin?# || top_layer_administrator
    end
end