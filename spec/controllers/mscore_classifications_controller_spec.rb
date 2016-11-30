require 'spec_helper'
require 'rails_helper'

RSpec.describe MscoreClassificationsController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @mscore_classification = MscoreClassification.new
        get :new, format: 'js'
      end
      it { expect(assigns[:mscore_classification]).to be_a_new(MscoreClassification) }
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
      it 'creates the mscore_classification' do
        expect do
          post :create, mscore_classification: attributes_for(:mscore_classification)
        end.to change(MscoreClassification, :count).by(1)
      end

      it 'redirects to the "show" action for the new mscore_classification' do
        post :create, mscore_classification: attributes_for(:mscore_classification)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the mscore_classification' do
        expect do
          post :create, mscore_classification: attributes_for(:mscore_classification, name: nil)
        end.to_not change(MscoreClassification, :count)
      end

      it 'redirects to the previous page' do
        post :create, mscore_classification: attributes_for(:mscore_classification, name: nil)
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
      @mscore_classification = FactoryGirl.create(:mscore_classification)
    end
    it 'should redirect to index with a notice on successful update' do
      @attr = { name: 'Waste Management' }
      put :update, id: @mscore_classification.id, mscore_classification: @attr
      expect(flash[:success]).to eq('Mscore classification was successfully updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { name: nil }
      put :update, id: @mscore_classification.id, mscore_classification: @attr
      expect(assigns[:mscore_classification]).not_to be_new_record
      expect(flash[:danger]).to eq('Mscore classification was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @mscore_classification = create(:mscore_classification)
        delete :destroy, id: @mscore_classification.id
      end

      it { expect(assigns(:mscore_classification).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
