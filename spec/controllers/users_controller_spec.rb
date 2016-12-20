
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
      it { expect(response).to render_template(:new) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = nil
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
      it { expect(response.content_type).to eq('text/javascript') }
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

  describe '#deactivate' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        @new_user = create(:user)
        session[:user_id] = @user.id
        post :deactivate, id: @new_user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq("#{@user.firstname} #{@user.surname}'s account deactivated successfully.") }
      it { expect(response).to redirect_to(:back) }
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
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        @admin = create(:user)
        session[:user_id] = @admin.id
        post :set_admin, id: @user.id
      end
      it "should redirect to index with a notice on successful update" do
      @attr = { :admin => true}
      post :set_admin, :id => @user.id, :user => @attr
      expect(assigns[:user]).not_to be_new_record
      expect(flash[:success]).to eq("User set as System Administrator.")
      expect(response).to redirect_to :back
      end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        @new_user = create(:user)
        session[:user_id] = nil
        get :set_admin, id: @new_user.id
      end
      it { expect(flash[:danger]).to eq('Please log in.') }
      it { expect(response).to redirect_to(login_url) }
    end
  end

  describe '#set maximum attempts' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @users = User.all
        get :set_maximum_attempts,:attempts => 5
      end

      it "should redirect to index with a notice on successful update" do
      @attr = { :max_login_attempts => 5}
      get :set_maximum_attempts, :user => @attr
      expect(flash[:success]).to eq("Maximum login attempts updated successfully.")
      expect(response).to redirect_to :back
      end
      it "should redirect to index with a notice on unsuccessful update" do
      @attr = { :max_login_attempts => nil}
      post :set_maximum_attempts, :user => @attr
      expect(flash[:danger]).to eq("Maximum login attempts not updated.")
      expect(response).to redirect_to :back
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
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        @admin = create(:user)
        session[:user_id] = @admin.id
        get :set_normal_user, id: @user.id
      end

      it { expect(flash[:success]).to eq('User removed as System Administrator successfully.') }
      it { expect(response).to redirect_to(:back) }
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
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :set_super_user, user_id: @user.id
      end
      it "should redirect to index with a notice on successful update" do
      @attr = { :super_admin => true}
      post :set_super_user, :user_id => @user.id, :user => @attr
      expect(assigns[:user]).not_to be_new_record
      expect(flash[:success]).to eq("User set to super user/admin successfully.")
      expect(response).to redirect_to :back
      end
      it "should redirect to index with a notice on unsuccessful update" do
      @attr = { :super_admin => true}
      post :set_super_user, :user_id => nil, :user => @attr
      expect(assigns[:user]).not_to be_new_record
      expect(flash[:danger]).to eq("failed to set user as super user/admin.")
      expect(response).to redirect_to :back
      end

    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
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
        session[:user_id] = nil
        get :set_new_password, id: @user.id
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#terminate' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @admin = create(:user)
        @user = create(:user)
        session[:user_id] = @admin.id
        get :terminate, id: @user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq('Account terminated successfully.') }
      it { expect(response).to redirect_to(:back) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :terminate, id: @user.id
      end
      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#restore' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        @admin = create(:user)
        session[:user_id] = @admin.id
        @user.update_columns(terminated: true)
        get :restore, id: @user.id
      end
      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq('User restored successfully.') }
      it { expect(response).to redirect_to(:back) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :restore, id: @user.id
      end
      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#lock user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @admin = create(:user)
        @user = create(:user)
        session[:user_id] = @admin.id
        get :lock_user, id: @user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq("User's account locked successfully.") }
      it { expect(response).to redirect_to(:back) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :lock_user, id: @user.id
      end
      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#unlock user' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        @admin = create(:user)
        session[:user_id] = @admin.id
        get :unlock_user, id: @user.id
      end

      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq("Unlocked User's account successfully.") }
      it { expect(response).to redirect_to(:back) }
    end
    context 'when user is not logged in' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :unlock_user, id: @user.id
      end
      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe '#activate' do
    context 'user is correct user or user is admin and is logged on to the system' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        get :activate, id: @user.id
      end
      it { expect(response).to have_http_status(302) }
      it { expect(flash[:success]).to eq('Account activated successfully.') }
      it { expect(response).to redirect_to(:back) }
    end
    context 'user is not logged on to the system' do
      before do
        @user = create(:user)
        session[:user_id] = nil
        get :activate, id: @user.id
      end
      it { expect(flash[:danger]).to eq('Please log in.') }
      it { expect(response).to redirect_to(login_url) }
    end
  end

  describe 'POST #create' do

    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context 'with valid attributes' do
      it 'creates the kpi_concept' do
        expect{
				post :create, user: attributes_for(:user)
			}.to change(User,:count).by(1)
      end

      it 'redirects to back' do
        post :create, user: attributes_for(:user)
				expect(flash[:info]).to eq("Please check your email to confirm your account.")
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the user' do
				expect{
				post :create, user: attributes_for(:kpi_concept,email: nil)
			}.to_not change(User,:count)
      end
			it 'redirects to back' do
        post :create, user: attributes_for(:user,email: nil)
				expect(flash[:danger]).to eq("Failed to add new user. Please complete properly the fields below.")
        expect(response).to redirect_to :back
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @user = FactoryGirl.create(:user)
              @logged_in_user = FactoryGirl.create(:user)
              session[:user_id] = @logged_in_user.id
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :firstname => "CRR"}
          put :update, :id => @user.id, :user => @attr
					expect(assigns[:user]).not_to be_new_record
          expect(flash[:success]).to eq("User details updated successfully")
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :email => nil}
          put :update, :id => @user.id, :user => @attr
          expect(assigns[:user]).not_to be_new_record
          expect(flash[:danger]).to eq("Profile not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              @admin = FactoryGirl.create(:user)
              session[:user_id] = @admin.id
              delete :destroy,:id=>@user.id
          end
          it {expect(assigns(:user)).to eq(@user)}
          it { expect(flash[:success]).to eq("User deleted")}
          it {expect(response).to redirect_to :back}
    end
  end

end
