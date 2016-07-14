class SetupsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy]
  def index
    @setup = Setup.new
  	@setups = Setup.all
  end

  def show
  	@setup =Setup.find(params[:id])
  end

  def new
  	@setup=Setup.new
  end

  def edit
  	@setup=Setup.find(params[:id])
  end
  def create
  	@setup = Setup.new(setup_params)

  	if @setup.save
  		flash[:success]="Setup saved successfully."
      redirect_to setups_path
  	else
  		flash[:notice]="Setup not saved."
  		redirect_to setups_path
  	end
  end
  def update

    @setup = Setup.find(params[:id])

      if @setup.update(setup_params)
        flash[:success]='Setup was successfully updated.'
        redirect_to setups_path

      else
        flash[:danger]='Setup was not updated.'
        redirect_to :back
    end
  end

  # DELETE /municipalities/1
  # DELETE /municipalities/1.json
  def destroy
    @setup = Setup.find(params[:id])
    @setup.destroy
      redirect_to setups_path, notice: 'Setup was successfully deleted.'
  end

  private
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

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    # TO DO: Do this properly
    #redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
