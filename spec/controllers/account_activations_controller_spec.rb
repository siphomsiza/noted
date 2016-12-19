require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
  before(:each) do
    @user = User.find_by(email: "example-1@railstutorial.org")
    session[:user_id] = @user.id
  end
  describe '#edit' do
    context 'activate user' do
      before do
        @user.update_columns(activated: false)
        get :edit, :id => @user.id
      end
      it { expect(@user.activated).to be(false) }
      it 'should successfully create a session' do
        expect { get :edit, email: @user.email }
        expect { session[:user_id] = @user.id }
        expect(response).to redirect_to(set_new_password_url)
        expect(flash[:success]).to eq("Account activated!")
      end
    end
    context 'user is already activated or an error occured' do
      before do
        @user.update_columns(activated: true)
        get :edit, :id => @user.id
      end
      it { expect(@user.activated).to be(true) }
      it 'should display an error message' do
        expect { get :edit, email: @user.email }
        expect { session[:user_id] = @user.id }
        expect(response).to redirect_to(root_url)
        expect(flash[:danger]).to eq("Invalid activation link")
      end
    end
    end
end
