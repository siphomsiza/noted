require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
  before(:all) do
    user = User.find_by(email: "sandiswa@sableassets.co.za")
    session[:user_id] = user.id
    @user = user
  end
  describe 'GET#edit' do
    before do
      !@user.activated?
    end
    context 'activate user' do
      it { expect(@user.activated).to be(false) }
      it 'should successfully create a session' do
        expect(response).to have_http_status(200)
        expect { get :edit, email: @user.email }
        expect { session[:user_id] = @user.id }
      end
    end
    end
  end
  describe "#edit" do
    before do
      @user.activated?
    end
    context 'user has been activated' do
      it { expect(@user.activated).to be(true) }
      it 'should display a message' do
        expect(response).to have_http_status(200)
      end
  end
end
