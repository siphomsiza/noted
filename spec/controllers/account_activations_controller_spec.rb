require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
  before(:all) do
    create(:user)
    session[:user_id] = @user.id
    @user = User.find_by(email: "casey@sableassets.com")
  end
  describe 'GET #edit' do
    context 'User is activated' do
      it { expect(@user.activated).to be(true) }
      it 'should successfully create a session' do
        expect(response).to have_http_status(200)
        expect { get :edit, email: @user.email }
        expect { session[:user_id] = @user.id }
      end
    end
    context 'User is not activated' do
      it { expect(@user.activated).to be(false) }
      it 'should display a message' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
