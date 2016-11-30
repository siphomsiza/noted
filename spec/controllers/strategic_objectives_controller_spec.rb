require 'spec_helper'
require 'rails_helper'

RSpec.describe StrategicObjectivesController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @strategic_objective = StrategicObjective.new
        get :new, format: 'js'
      end

      it { expect(assigns[:strategic_objective]).to be_a_new(StrategicObjective) }
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
      it 'creates the strategic_objective' do
        expect do
          post :create, strategic_objective: attributes_for(:strategic_objective)
        end.to change(StrategicObjective, :count).by(1)
      end

      it 'redirects to the "show" action for the new strategic_objective' do
        post :create, strategic_objective: attributes_for(:strategic_objective)
        expect(flash[:success]).to eq('Strategic objective was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the strategic_objective' do
        expect do
          post :create, strategic_objective: attributes_for(:strategic_objective, name: nil)
        end.to_not change(StrategicObjective, :count)
      end

      it 're-renders the "new" view' do
        post :create, strategic_objective: attributes_for(:strategic_objective, name: nil)
        expect(flash[:danger]).to eq('Strategic objective was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
      @strategic_objective = FactoryGirl.create(:strategic_objective)
    end

    it 'should redirect to index with a notice on successful update' do
      @attr = { name: 'Develop and build skilled and knowledgeable workforce' }
      put :update, id: @strategic_objective.id, strategic_objective: @attr
      expect(flash[:success]).to eq('Strategic objective was successfully updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { name: nil }
      put :update, id: @strategic_objective.id, strategic_objective: @attr
      expect(assigns[:strategic_objective]).not_to be_new_record
      expect(flash[:danger]).to eq('Strategic objective was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @strategic_objective = create(:strategic_objective)
        delete :destroy, id: @strategic_objective.id
      end

      it { expect(assigns(:strategic_objective).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
