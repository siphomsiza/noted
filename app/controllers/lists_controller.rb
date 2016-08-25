class ListsController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy,:edit_capital_projects]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy,:edit_capital_projects]
def index
  begin

      @client = YahooWeather::Client.new
      @response = @client.fetch(1582504)
      @doc = @response.doc
      @forecast = @doc["item"]["forecast"]
    #@response = @client.fetch_by_location('New York')
    #@response.units.temperature
    #@response.condition.temp

rescue SocketError => e
  flash[:notice] = "received Exception #{e.message}"
  puts "received Exception #{e}"
end
end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin? || current_user.super_admin?
    end

end
