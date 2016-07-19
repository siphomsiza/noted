class PagesController < ApplicationController
  before_action :logged_in_user, only: [:about,:new,:setup,:dashboard]
  before_action :admin_user,     only: [:about,:new,:setup,:dashboard]
  before_action :top_layer_administrator,     only: [:dashboard]
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def setup

  end
  def dashboard

    @sdbip_time_periods = SdbipTimePeriod.where(["end_date = ? OR end_date = ?",Date.today,Date.today.days_ago(-7)])
    @users = User.all
    @departmental_sdbips = DepartmentalSdbip.order(performance_standard: :asc)
    @departmental_sdbips_kpa = DepartmentalSdbip.all
    @departments = Department.includes(:departmental_sdbips)
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
  private
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
    def top_layer_administrator
      redirect_to(root_url) unless (!current_user.role.blank? && (current_user.role.top_layer_administrator? || current_user.role.assurance_provider? || current_user.role.audit_log_reporting? || current_user.role.secondary_time_period? )) || current_user.admin?
    end
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin? || top_layer_administrator
    end
end
