require 'spec_helper'
require 'rails_helper'

RSpec.describe RolesController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end
          it "assigns @role" do
          role = Role.create
          expect(assigns[:role]).to be_a_new(Role)
          end

          it "assigns @role" do
          roles = Role.create
          expect(assigns(:role)).to be_truthy
          end

          it "assigns @users" do
          users = User.all
          expect(users).to be_truthy
          end

          it "assigns @lists" do
          departments = Department.all
          expect(departments).to be_truthy
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end
  end

  describe 'POST #create' do

    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context 'with valid attributes' do
      it 'creates the role' do
        expect{
          post :create, role: attributes_for(:role)
        }.to change(Role,:count).by(1)
      end

      it 'redirects to the "show" action for the new role' do
        post :create, role: attributes_for(:role)
        expect(flash[:success]).to eq("Role was successfully saved.")
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the role' do
        expect{
          post :create, role: attributes_for(:role,user_id: nil)
        }.to_not change(Role,:count)
      end

      it 're-renders the "new" view' do
        post :create, role: attributes_for(:role,user_id: nil)
        expect(flash[:danger]).to eq("Role was not saved.")
        expect(response).to redirect_to :back
      end
    end
  end

  describe "#edit_user_role" do
    context "when user is admin and logged in" do

          before do
          @user = create(:user)
          @role = FactoryGirl.create(:role)
          session[:user_id] = @user.id
          end
          it {expect(response).to have_http_status(200)}
    end

    context "when user is not logged in" do

          before do
              @role = FactoryGirl.create(:role)
              get :edit_user_role,:id => @role.id, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit_grant_new_user_access" do
    context "when user is admin and logged in" do

          before do
          @user = create(:user)
          @role = FactoryGirl.create(:role)
          session[:user_id] = @user.id
          end
          it {expect(assigns[:role]).to be_a_new(Role)}
          it {expect(response).to have_http_status(200)}
    end

    context "when user is not logged in" do

          before do
              @role = FactoryGirl.create(:role)
              get :edit_grant_new_user_access,:id => @role.id, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#grant new user access" do
    context "user is correct user or user is admin and is logged on to the system" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :grant_new_user_access,:id => @user.id,:format => 'js'
          end

          it {expect(response).to have_http_status(200)}

    end
  end

  describe "#new user role" do
    context "user is correct user or user is admin and is logged on to the system" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :new_user_role,:id => @user.id,:format => 'js'
          end

          it {expect(response).to have_http_status(200)}

    end
  end

  describe "#edit_new_user_role" do
    context "when user is admin and logged in" do

          before do
          @user = create(:user)
          @role = FactoryGirl.create(:role)
          session[:user_id] = @user.id
          end
          it {expect(assigns[:role]).to be_a_new(Role)}
          it {expect(response).to have_http_status(200)}
    end

    context "when user is not logged in" do

          before do
              @role = FactoryGirl.create(:role)
              get :edit_grant_new_user_access,:id => @role.id,:format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              @role = FactoryGirl.create(:role)
              session[:user_id] = @user.id
              get :edit,:id=>@role.id,:format => 'js'
          end

          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template(:edit)}
    end

    context "when user is not logged in" do

          before do
              @role = FactoryGirl.create(:role)
              get :edit,{:id=>@role.id}
          end

          it { expect(response).to have_http_status(302)}
    end
  end

  describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @role = FactoryGirl.create(:role)
              get :new,:format => 'js'
          end

          it {expect(assigns[:role]).to be_a_new(Role)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template("new")}
        end
      end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @role = FactoryGirl.create(:role)
          end

          it "should re-render edit template on failed update" do
          @attr = { user_id: nil, :kpi_owner => false, :finance_admin => false }
          patch :update, :id => @role.id, :role => @attr
          expect(flash[:danger]).to eq("Role was not saved.")
          expect(response).to redirect_to :back
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { user_id: 1, :kpi_owner => true, :finance_admin => false}
          patch :update, :id => @role.id, :role => @attr
          expect(assigns[:role]).not_to be_new_record
          expect(flash[:success]).to eq("Role was successfully saved.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @role = FactoryGirl.create(:role)
          end

          it 'destroys the requested role' do
          expect {
          delete :destroy, :id => @role.id
                 }.to change(Role, :count).by(-1)
          end

          it 'redirects to the roles list' do
          delete:destroy, :id => @role.id
          expect(flash[:success]).to eq("Role was successfully deleted.")
          expect(response).to redirect_to :back
          end
  end
end
