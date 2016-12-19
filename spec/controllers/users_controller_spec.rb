
require 'spec_helper'
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
  describe '#report users' do
    context 'User is logged in and admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :report_users
      end
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('report_users') }
    end
    context 'User is not logged in/is not admin' do
      before do
        session[:user_id] = nil
        get :report_users
      end
      it { expect(flash[:danger]).to eq('Please log in.') }
      it { expect(response).to redirect_to(login_url) }
    end
  end
  describe '#setup users' do
    context 'User is logged in and admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :setup_users
      end
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('setup_users') }
    end
    context 'User is not logged in/is not admin' do
      before do
        session[:user_id] = nil
        get :setup_users
      end
      it { expect(flash[:danger]).to eq('Please log in.') }
      it { expect(response).to redirect_to(login_url) }
    end
  end
  describe '#index' do
    let(:admin) { build_stubbed(:admin) }
    let(:user) { build_stubbed(:user) }
    context 'User is admin and is logged in' do
      before(:each) do
        @user = create(:user)
        session[:user_id] = @user.id
        get :index
      end

      it 'assigns @user' do
        user = User.create
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'assigns @users' do
        @users = User.all
      end

      it 'assigns @user' do
        admin_users = User.create
        expect(assigns(:admin_users)).to include(User)
      end

      it 'assigns @user' do
        active_users = User.create
        expect(assigns(:active_users)).to include(User)
      end

      it 'assigns @user' do
        user_login_attempts = User.create
        expect(assigns(:user_login_attempts)).to include(User)
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('index') }
    end

    context 'User is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :index
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#create' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        user_params = FactoryGirl.attributes_for(:user)
        get :index
      end

      it 'creates user' do
        user_params = FactoryGirl.attributes_for(:user)
        expect { post :create, user: user_params }.to change(User, :count).by(1)
        user = assigns(:user)
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to redirect_to users_path }
      # it {expect(flash[:info]).to eq("Please check your email to activate your account.")}
      it { expect(response).to render_template('users/index') }
    end
    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get index: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :new
      end

      it { expect(assigns[:user]).to be_a_new(User) }
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to users_path }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :new
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#show' do
    context 'user is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :show, id: @user.id
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('users/show') }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :show, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#edit' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :edit, id: @user.id, :format => 'js'
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('edit') }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :edit, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#edit new user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        post :edit_new_user, id: @user.id, :format => 'js'
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template('users/edit_new_user') }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        post :edit_new_user, id: @user.id, :format => 'js'
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#edit active user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        post :edit_active_user, id: @user.id, :format => 'js'
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template('users/edit_active_user') }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        post :edit_active_user, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#edit user profile' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        post :edit_user_profile, id: @user.id, :format => 'js'
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template('users/edit_user_profile') }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        post :edit_user_profile, id: @user.id, :format => 'js'
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#update' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        request.env['HTTP_REFERER'] = root_url
      end

      it 'update user' do
        patch :update, id: @user.id, user: FactoryGirl.attributes_for(:user)
        expect { assigns[:user].to eq(User(user_params)) }
        expect { patch :update, id: @user.id }
      end

      it { expect(response.status).to eq(200) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        patch :update, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#deactivate' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        @new_user = create(:user)
        session[:user_id] = @user.id
        post :deactivate, id: @new_user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq("User's account deactivated successfully") }
      it { expect(response).to redirect_to(users_path) }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        post :deactivate, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#set admin' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        @new_user = create(:user)
        session[:user_id] = @user.id
        get :index
      end
      it '' do
        expect { post :set_admin, id: @new_user.id, user: attributes_for(:user).merge(users_attributes: [attributes_for(:user)]) }
      end
      it { expect(response).to have_http_status(200) }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        @new_user = create(:user)
        session[:user_id] = nil
        get :set_admin, id: @new_user.id
      end

      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#set maximum attempts' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @users = User.all
        get :setup_users
      end

      it 'update maximum log in attempts' do
        expect { post :set_maximum_attempts, @users.update_all(max_login_attempts: 5) }
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response).to redirect_to(setup_users) }
      it { expect(flash[:success]).to eq('Maximum login attempts updated successfully.') }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        post :set_maximum_attempts, id: @user.id
      end
      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#set normal user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :set_normal_user, id: @user.id
      end

      it { expect(flash[:success]).to eq('User removed as System Administrator successfully.') }
      it { expect(response).to redirect_to(users_path) }
    end
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @logged_in_user = create(:user)
        @user = nil
        session[:user_id] = @logged_in_user.id
        get :set_normal_user, id: @user.id
      end
      it { expect(flash[:danger]).to eq('Failed to remove user as System Administrator.') }
      it { expect(response).to redirect_to(users_path) }
    end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :set_normal_user, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#set_super_user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :set_super_user, id: @user.id, :format => 'js'
      end
      it '' do
        expect { post :set_super_user, id: @new_user.id, user: attributes_for(:user).merge(users_attributes: [attributes_for(:user)]) }
      end

      it { expect(response).to have_http_status(200) }
      it { expect(flash[:danger]).to eq("failed to set #{@user.firstname} #{@user.surname} as super user/admin.") }
      it { expect(response).to redirect_to users_path }
    end
    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :set_super_user, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#set_new_password' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :set_new_password, id: @user.id
      end

      it { expect(response).to have_http_status(200) }
      # it {expect(flash[:success]).to eq("User removed from System Admin role successfully.") }
    end
    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :set_new_password, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#terminate' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :terminate, id: @user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq('Account terminated successfully.') }
      it { expect(response).to redirect_to(users_url) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :terminate, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#restore' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :restore, id: @user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq('User restored successfully.') }
      it { expect(response).to redirect_to(users_path) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :restore, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#lock user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :lock_user, id: @user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq('Account locked successfully.') }
      it { expect(response).to redirect_to(users_path) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :lock_user, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#unlock user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :unlock_user, id: @user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq("Unlocked user's account successfully.") }
      it { expect(response).to redirect_to(users_path) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :unlock_user, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#activate' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :activate, id: @user.id
      end
      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq('Account activated successfully.') }
      it { expect(response).to redirect_to(users_path) }
    end
  end
  def user
    @user ||= User.new
  end

  describe 'Get destroy' do
    let!(:user_params) do
      user_params = { username: "username#{rand(1000)}",
                      email: "user#{rand(1000)}@factory.com",
                      password: 'Password123',
                      password_confirmation: 'Password123',
                      admin: false,
                      description: 'Nihil eligendi ab debitis iure.' }
    end
    context 'when user is logged in' do
      before do
        @user = create(:user)
        @new_user = create(:user)
        session[:user_id] = @user.id
        get :index #:destroy,{:id=>@new_user.id}
      end
      it 'user destroy' do
        delete :destroy, { id: user.id }, { user_id: user.id }, user: user_params
        expect(response).to redirect_to(users_path)
      end
      it '' do
        expect { delete :destroy, id: @new_user.id }.to change(User, :count).by(-1)
      end
      context 'when user is not logged in' do
        before do
          @user = create(:user)
          session[:user_id] = @user.id
          get :index
        end

        it { expect(response).to redirect_to(login_path) }
        it { expect(flash[:danger]).to eq('Please log in.') }
      end
    end
  end
  def log_in(user)
    session[:user_id] = user.id
     end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
end
