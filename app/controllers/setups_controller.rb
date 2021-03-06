class SetupsController < ApplicationController
  before_action :set_setup, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?
  def index
    weather_details
    @setup = Setup.new
  	@setups = Setup.all
  end

  def edit
  	@setup=Setup.find(params[:id])
  end
  def create
  	@setup = Setup.new(setup_params)

  	if @setup.save
  		flash[:success]="Setup saved successfully."
      redirect_to setups_path
  	end
  end
  def update
      if @setup.update(setup_params)
        flash[:success]='Setup was successfully updated.'
        redirect_to setups_path
      end
  end

  # DELETE /municipalities/1
  # DELETE /municipalities/1.json
  def destroy
    @setup.destroy
      redirect_to setups_path, notice: 'Setup was successfully deleted.'
  end

  private
  def js_request?
      request.format.js?
  end
  def setup_params
  	params.require(:setup).permit(:performance_comments,:performance_length,:project_life_cycle,:include_previous_departmental_actual,:include_departmental_previous_comments,:include_departmental_next_target,:include_toplayer_previous_target,:include_toplayer_next_target,:include_toplayer_previous_comments,:attach_poe)
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
  def set_setup
    @setup = Setup.find(params[:id])
  end
  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin? || current_user.super_admin?
  end
end
