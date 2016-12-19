require 'spec_helper'
require 'rails_helper'

RSpec.describe SdbipTimePeriodsController, type: :controller do
  describe 'GET index' do
    context 'when user is admin and logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @sdbip_time_period = SdbipTimePeriod.new
        get :index
      end
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('index') }
    end
    it 'assigns @sdbip_time_period' do
      expect(assigns[:sdbip_time_period]).to eq(SdbipTimePeriod.new)
    end
    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        get :index
      end
      it { expect(flash[:danger]).to eq('Please log in.') }
      it { expect(response).to redirect_to(login_url) }
    end
  end

  describe '#edit' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
        session[:user_id] = @user.id
        get :edit, id: @sdbip_time_period.id, format: 'js'
      end
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template('edit') }
    end
    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
        get :edit, id: @sdbip_time_period.id, format: 'js'
      end
      it { expect(flash[:danger]).to eq('Please log in.') }
      it { expect(response).to redirect_to(login_url) }
    end
  end

  describe 'POST #import' do
    it 'redirects to the home page' do
      allow(SdbipTimePeriod).to receive(:import).with('foo.txt')
      post :import, file: 'foo.txt'
      expect(response).to redirect_to sdbip_time_periods_url
    end

    it 'adds a flash notice' do
      allow(SdbipTimePeriod).to receive(:import).with('foo.txt')
      post :import, file: 'foo.txt'
      expect(flash[:success]).to eq 'Time periods imported successfully.'
    end

    it 'imports the SdbipTimePeriod file' do
      expect(SdbipTimePeriod).to receive(:import).with('foo.txt')
      post :import, file: 'foo.txt'
    end
  end
  describe 'GET #show' do
    it 'assigns the requested sdbip_time_period to @sdbip_time_period' do
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
      get :show, id: sdbip_time_period
    end
    it 'renders the #show view' do
      get :show, id: @sdbip_time_period.id
      expect(response).to render_template :show
    end
  end

  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @sdbip_time_period = create(:sdbip_time_period)
        session[:sdbip_time_period_id] = @sdbip_time_period.id
        get :new
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('new') }
    end
  end
  describe 'POST #create' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end
    context 'with valid attributes' do
      it 'creates the sdbip_time_period' do
        expect do
          post :create, sdbip_time_period: attributes_for(:sdbip_time_period)
        end.to change(SdbipTimePeriod, :count).by(1)
      end

      it 'redirects to back' do
        post :create, sdbip_time_period: attributes_for(:sdbip_time_period)
        expect(flash[:success]).to eq('Sdbip Time Period was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the sdbip_time_period' do
        expect do
          post :create, sdbip_time_period: attributes_for(:sdbip_time_period, period: nil)
        end.to_not change(SdbipTimePeriod, :count)
      end
      it 'redirects to back' do
        post :create, sdbip_time_period: attributes_for(:sdbip_time_period, period: nil)
        expect(flash[:danger]).to eq('Sdbip Time Period was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
    end

    it 'should redirect to index with a notice on successful update' do
      @attr = { period: Date.today }
      put :update, id: @sdbip_time_period.id, sdbip_time_period: @attr
      expect(assigns[:sdbip_time_period]).not_to be_new_record
      expect(flash[:success]).to eq('Sdbip Time Period was successfully updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { period: nil }
      put :update, id: @sdbip_time_period.id, kpi_concept: @attr
      expect(assigns[:sdbip_time_period]).not_to be_new_record
      expect(flash[:danger]).to eq('Sdbip Time Period was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe '#send_notification' do
    before do
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
      get :send_notification
    end
  end
  describe '#update_status' do
    before do
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
      get :update_status
    end
  end
  describe '#close_primary' do
    before do
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
      get :close_primary
    end
  end
  describe '#close_secondary' do
    before do
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
      get :close_secondary
    end
  end
  describe '#close_finance' do
    before do
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
      get :close_finance
    end
  end
  describe '#update_time_periods' do
    before do
      @sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
      get :update_time_periods
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @sdbip_time_period = create(:sdbip_time_period)
        delete :destroy, id: @sdbip_time_period.id
      end

      it { expect(assigns(:sdbip_time_period).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to(sdbip_time_periods_url) }
    end
  end
end
