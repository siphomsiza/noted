require 'spec_helper'
require 'rails_helper'

RSpec.describe AreasController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :new, :format => 'js'
      end
      it { expect(assigns[:area]).to be_a_new(Area) }
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template('new') }
    end
  end
  describe 'POST #create' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end

    context 'with valid attributes' do
      it 'creates the area' do
        post :create, area: attributes_for(:area)
        expect(Area.count).to eq(Area.count + 1)
      end
      it 'redirects to the "show" action for the new area' do
        post :create, area: attributes_for(:area)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the area' do
        post :create, area: attributes_for(:area, name: nil)
        expect(Area.count).to eq(Area.count)
      end
      it 're-renders the "new" view' do
        post :create, area: FactoryGirl.attributes_for(:area, name: nil)
      end
    end
  end
  describe '#update' do
    before(:each) do
      @area = FactoryGirl.create(:area)
      request.env['HTTP_REFERER'] = root_url
    end
    it 'should re-render edit template on failed update' do
      @attr = { name: '' }
      put :update, id: @area.id, area: @attr
      expect(flash[:danger]).to eq('Area was not updated.')
    end
    it 'should redirect to index with a notice on successful update' do
      @attr = { name: 'New Piet Retief' }
      put :update, id: @area.id, area: @attr
      expect(flash[:success]).to eq('Area was successfully updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @area = Area.create!(name: Faker::Address.city)
        delete :destroy, id: @area.id
      end
			it "deletes the area" do
				expect{
					delete :destroy, :id => @area.id
				}.to change(Area,:count).by(-1)
			end
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
