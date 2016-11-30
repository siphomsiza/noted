require 'spec_helper'
require 'rails_helper'

RSpec.describe RiskRatingsController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @risk_rating = RiskRating.new
        get :new, format: 'js'
      end

      it { expect(assigns[:risk_rating]).to be_a_new(RiskRating) }
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
      it 'creates the risk_rating' do
        expect do
          post :create, risk_rating: attributes_for(:risk_rating)
        end.to change(RiskRating, :count).by(1)
      end

      it 'redirects to the "show" action for the new risk_rating' do
        post :create, risk_rating: attributes_for(:risk_rating)
        expect(flash[:success]).to eq('Risk Rating was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the risk_rating' do
        expect do
          post :create, risk_rating: attributes_for(:risk_rating, name: nil)
        end.to_not change(RiskRating, :count)
      end

      it 're-renders the "new" view' do
        post :create, risk_rating: attributes_for(:risk_rating, name: nil)
        expect(flash[:danger]).to eq('Risk Rating was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
      @risk_rating = FactoryGirl.create(:risk_rating)
    end

    it 'should redirect to index with a notice on successful update' do
      @attr = { name: 'High', code: 'H' }
      put :update, id: @risk_rating.id, risk_rating: @attr
      expect(flash[:success]).to eq('Risk Rating was successfully updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { name: nil, code: 'H' }
      put :update, id: @risk_rating.id, risk_rating: @attr
      expect(assigns[:risk_rating]).not_to be_new_record
      expect(flash[:danger]).to eq('Risk Rating was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @risk_rating = create(:risk_rating)
        delete :destroy, id: @risk_rating.id
      end

      it { expect(assigns(:risk_rating).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
