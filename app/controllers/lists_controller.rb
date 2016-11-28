class ListsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :admin_user,     only: [:index]
  def index
    weather_details
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin? || current_user.super_admin?
  end
end
