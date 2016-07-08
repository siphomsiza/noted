class PagesController < ApplicationController
  before_action :logged_in_user, only: [:new,:setup,:dashboard]
  before_action :admin_user,     only: [:new,:setup,:dashboard]
  before_action :municipal_manager_user,     only: [:dashboard]
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
  def setup
    @setups = Setup.all
    @lists = List.all
    @departments = Department.all
    @headings = Heading.all
    @roles = Role.all

  end
  def dashboard

    @sdbip_time_periods = SdbipTimePeriod.where(["end_date = ? OR end_date = ?",Date.today,Date.today.days_ago(-7)])
    @users = User.all
    @departmental_sdbips = DepartmentalSdbip.order(performance_standard: :asc)
    @client = YahooWeather::Client.new
    @response = @client.fetch(1582504)
    @doc = @response.doc
    @forecast = @doc["item"]["forecast"]
    #@response = @client.fetch_by_location('New York')
    #@response.units.temperature
    #@response.condition.temp
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
    def municipal_manager_user
      redirect_to(root_url) unless (!current_user.role.blank? && current_user.role.municipal_manager?) || current_user.admin?
    end
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin? || municipal_manager_user
    end
end
