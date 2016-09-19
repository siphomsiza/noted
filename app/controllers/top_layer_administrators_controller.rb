class TopLayerAdministratorsController < ApplicationController
  before_action :set_top_layer_administrator, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index,:show,:new,:edit,:destroy]
  before_action :admin_user,     only: [:index,:show,:new,:edit,:destroy]
  # GET /top_layer_administrators
  # GET /top_layer_administrators.json
  def index
    @users_for_departmental_administrators = User.where('id NOT IN(SELECT (user_id) FROM top_layer_administrators)')
    @top_layer_administrator = TopLayerAdministrator.new
    @departments = Department.includes(:top_layer_administrators).paginate(page: params[:page],per_page: 10)
  end

  # GET /top_layer_administrators/1
  # GET /top_layer_administrators/1.json
  def show
  end

  # GET /top_layer_administrators/new
  def new
    @top_layer_administrator = TopLayerAdministrator.new
  end

  # GET /top_layer_administrators/1/edit
  def edit
  end

  # POST /top_layer_administrators
  # POST /top_layer_administrators.json
  def create
    @top_layer_administrator = TopLayerAdministrator.new(top_layer_administrator_params)

      if @top_layer_administrator.save
        flash[:success] = 'Top layer administrator was successfully created.'
        redirect_to top_layer_administrators_url

      else
        flash[:danger] = 'Top layer administrator was not created.'
        redirect_to top_layer_administrators_url
      end
  end

  # PATCH/PUT /top_layer_administrators/1
  # PATCH/PUT /top_layer_administrators/1.json
  def update

      if @top_layer_administrator.update(top_layer_administrator_params)
        flash[:success] = 'Top layer administrator was successfully updated.'
        redirect_to top_layer_administrators_url
      else
        flash[:danger] = 'Top layer administrator was not updated.'
        redirect_to top_layer_administrators_url
      end

  end

  # DELETE /top_layer_administrators/1
  # DELETE /top_layer_administrators/1.json
  def destroy
    @top_layer_administrator.destroy
    flash[:success] = 'Top layer administrator was successfully deleted.'
    redirect_to top_layer_administrators_url

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_top_layer_administrator
      @top_layer_administrator = TopLayerAdministrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def top_layer_administrator_params
      params.require(:top_layer_administrator).permit(:user_id, :can_edit, :can_create, :can_approve, :can_update)
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
