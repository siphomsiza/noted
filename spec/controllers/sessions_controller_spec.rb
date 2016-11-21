require 'spec_helper'
require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "#new" do
    context "If" do

          before do
              get :new, session[:user_id] = nil
          end

          it "renders the log in template" do
          expect(response).to render_template("new")
          end
    end
  end

  describe "#new" do
    context "If there's a session" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :new
          end

          it "redirects to introduction page" do
          expect(response).to redirect_to(introduction_url)
          end
    end
  end

  describe 'POST #create' do
    
  context 'when password is invalid' do
    it 'renders the page with error' do
      user = create(:user)

      post :create, session: { email: user.email, password: 'invalid' }

      expect(response).to render_template(:new)
      expect(flash[:notice]).to match(/^Email and password do not match/)
    end
  end

  context 'when password is valid' do
    it 'sets the user in the session and redirects them to their dashboard' do
      user = create(:user)

      post :create, session: { email: user.email, password: user.password }

      expect(response).to redirect_to '/dashboard'
      expect(controller.current_user).to eq user
    end
    context "User is activated, not terminated, not locked and correct password" do

          before do
              get :new
              @user = create(:user)
          end

          it { expect(@user.activated).to be(true)}
          it { expect(@user.terminated).to be(false)}
          it { expect(@user.login_attempts).to be < @user.max_login_attempts }

          it "should successfully create a session" do
          expect { post :create, { :email=> @user.email, :password=>@user.password } }
          expect { session[:user_id] = @user.id }
          end

          it "Increments user log on counts" do
          expect { @user.login_count = @user.login_count + 1 } 
          end
  end
  context "User is not activated" do

          before do
              get :new
              @user = create(:user)
              @user.activated = false
          end

          it { expect(@user.activated).to be(false)}

          it "should display a message" do
          expect(response).to have_http_status(200)
          end
    end

    context "User is terminated" do

          before do
              get :new
              @user = create(:user)
              @user.terminated = true
          end

          it { expect(@user.terminated).to be(true)}

          it "should display a warning message" do
          expect(response).to have_http_status(200)
          end
    end
  
    context "User is locked" do

          before do
              get :new
              @user = create(:user)
              @user.login_attempts = @user.max_login_attempts + 1
          end

          it { expect(@user.login_attempts).to be > @user.max_login_attempts }
          it {expect(response).to have_http_status(200)}
    end

    context "User provided wrong password" do

          before do
              get :new
              @user = create(:user)
          end

          it { expect(@user.activated).to be(true)}
          it { expect(@user.terminated).to be(false)}
          it { expect(@user.login_attempts).to be < @user.max_login_attempts }

          it "should successfully create a session" do
          expect { post :create, { :email=> @user.email, :password=>"ghgh576fg55654" } }
          end
    end
  end
end

  describe "#destroy" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              delete :destroy, :id => @user.id
          end

          it { expect(session[:user_id]).to eq(nil) }
          it { expect(response).to redirect_to(root_url) }
  end
end
