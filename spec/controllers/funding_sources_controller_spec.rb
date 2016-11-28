require 'spec_helper'
require 'rails_helper'

RSpec.describe FundingSourcesController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @funding_source = FundingSource.new
        get :new, format: 'js'
      end

      it { expect(assigns[:funding_source]).to be_a_new(FundingSource) }
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template('funding_sources/new') }
    end
  end

  describe 'POST #create' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end

    context 'with valid attributes' do
      it 'creates the funding_source' do
        post :create, funding_source: attributes_for(:funding_source)
				expect do
          post :create, :funding_source => FactoryGirl.attributes_for(:funding_source)
        end.to change(FundingSource, :count).by(1)
        expect(assigns(:funding_source)).to be_a(FundingSource)
        expect(assigns(:funding_source)).to be_persisted
      end

      it 'redirects to the "show" action for the new funding_source' do
        post :create, funding_source: attributes_for(:funding_source)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the funding_source' do
        post :create, funding_source: attributes_for(:invalid_funding_source, name: nil)
				expect do
          post :create, :funding_source => FactoryGirl.attributes_for(:invalid_funding_source)
        end.to_not change(FundingSource, :count)
      end

      it 're-renders the "new" view' do
        post :create, funding_source: attributes_for(:funding_source, name: nil)
      end
    end
  end

  describe '#update' do
    before(:each) do
      @funding_source = FactoryGirl.create(:funding_source)
      request.env['HTTP_REFERER'] = root_url
    end

    it 'should re-render edit template on failed update' do
      @attr = { name: 'CRR' }
      put :update, id: @funding_source.id, funding_source: @attr
      expect(flash[:success]).to eq('Funding source was successfully updated.')
    end

    it 'should redirect to index with a notice on successful update' do
      @attr = { name: nil }
      put :update, id: @funding_source.id, funding_source: @attr
      expect(assigns[:funding_source]).not_to be_new_record
      expect(flash[:danger]).to eq('Funding source was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @funding_source = create(:funding_source)
        delete :destroy, id: @funding_source.id
      end

      it { expect(assigns(:funding_source).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
