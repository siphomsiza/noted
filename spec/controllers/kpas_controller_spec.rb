require 'spec_helper'
require 'rails_helper'

RSpec.describe KpasController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        kpa = Kpa.new
        get :new, format: 'js'
      end

      it { expect(assigns[:kpa]).to be_a_new(Kpa) }
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
      it 'creates a new kpa' do
        expect do
          post :create, :kpa => FactoryGirl.attributes_for(:kpa)
        end.to change(Kpa, :count).by(1)
      end
      it 'should redirect to index with a notice on successful create' do
				post :create, :kpa => FactoryGirl.attributes_for(:kpa)
        expect(flash[:success]).to eq('KPA was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpa' do
        expect do
          post :create, :kpa => FactoryGirl.attributes_for(:invalid_kpa)
        end.to_not change(Kpa, :count)
      end
      it 'should redirect to index with a notice on successful create' do
				post :create, :kpa => FactoryGirl.attributes_for(:invalid_kpa)
        expect(flash[:danger]).to eq('KPA was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      @kpa = FactoryGirl.create(:kpa)
      request.env['HTTP_REFERER'] = root_url
    end
    context 'with invalid data' do
      it 'should re-render edit template on failed update' do
        @attr = { code: nil, name: nil }
        put :update, :id => @kpa.id, kpa: @attr
        expect(flash[:danger]).to eq('KPA was not updated.')
      end
    end
    context 'with valid data' do
      it 'should redirect to index with a notice on successful update' do
        @attr = { name: 'Service Delivery', code: '564' }
        put :update, id: @kpa.id, kpa: @attr
        expect(flash[:success]).to eq('KPA was successfully updated.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before(:each) do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @kpa = create(:kpa)
        delete :destroy, id: @kpa.id
      end

      it { expect(assigns(:kpa).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
