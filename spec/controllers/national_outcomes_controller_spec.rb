require 'spec_helper'
require 'rails_helper'

RSpec.describe NationalOutcomesController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @national_outcome = NationalOutcome.new
        get :new, format: 'js'
      end

      it { expect(assigns[:national_outcome]).to be_a_new(NationalOutcome) }
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
      it 'creates the national_outcome' do
        expect do
          post :create, national_outcome: attributes_for(:national_outcome)
        end.to change(NationalOutcome, :count).by(1)
      end

      it 'redirects to the index action for the new national_outcome' do
        post :create, national_outcome: attributes_for(:national_outcome)
        expect(flash[:success]).to eq('National outcome was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the national_outcome' do
        expect do
          post :create, national_outcome: attributes_for(:national_outcome, name: nil)
        end.to_not change(NationalOutcome, :count)
      end

      it 'redirects to the index action for the new national_outcome' do
        post :create, national_outcome: attributes_for(:national_outcome, name: nil)
        expect(flash[:danger]).to eq('National outcome was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
      @national_outcome = FactoryGirl.create(:national_outcome)
    end

    it 'should redirects to index on successful update' do
      @attr = { name: 'A development-orientated public service and inclusive citizenship' }
      put :update, id: @national_outcome.id, national_outcome: @attr
      expect(flash[:success]).to eq('National outcome was successfully updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { name: nil }
      put :update, id: @national_outcome.id, national_outcome: @attr
      expect(assigns[:national_outcome]).not_to be_new_record
      expect(flash[:danger]).to eq('National outcome was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @national_outcome = create(:national_outcome)
        delete :destroy, id: @national_outcome.id
      end

      it { expect(assigns(:national_outcome).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
