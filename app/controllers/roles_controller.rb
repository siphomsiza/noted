class RolesController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:grant_new_user_access,:grant_user_access,:destroy,:edit_user_role,:new_user_role,:edit_user_access]
  before_action :admin_user,     only: [:index,:show,:new,:grant_new_user_access,:grant_user_access,:edit,:destroy,:edit_user_role,:new_user_role,:edit_user_access]
  before_action :set_role, only: [:show, :edit, :update,:grant_user_access, :destroy,:edit_user_role,:edit_user_access]
  def index
    begin
        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
  rescue SocketError => e
    flash[:danger] = "received Exception #{e.message}"
  end
    @users_for_role = User.where('id NOT IN(SELECT (user_id) FROM roles)')
    @role = Role.new
    @roles = Role.paginate(page: params[:page],per_page: 15).includes(:user)
    @departments = Department.all
  end

  def show

  end
  def edit_user_role

  end
  def grant_user_access

  end
  def grant_new_user_access
    @role = Role.new
  end
  def new_user_role
   @role = Role.new
  end

  def edit_user_access

  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      flash[:success]= "Role was successfully saved"
      redirect_to :back
    else
      flash[:danger]= "Role was not saved"
      redirect_to :back
    end
  end

  def edit

  end

  def update
        @role = Role.find(params[:id])

    if @role.update_attributes(role_params)
      flash[:success] = "Role was successfully saved"
      redirect_to :back
    else
      flash[:danger] = "Role was not saved"
      redirect_to :back
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
      flash[:success] = "Role was successfully deleted"
      redirect_to :back
  end

  private
    def role_params
        params.require(:role).permit(:user_id,
          :kpi_owner, :top_layer_administrator, :audit_log_reporting,:setup,
          :assurance_provider,:finance_admin, :secondary_time_period)
    end

    def set_role
      @role = Role.find(params[:id])
    end

    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end

      # Confirms an admin user.
      def admin_user
        #redirect_to(root_url) unless
        current_user.admin?
      end
end
