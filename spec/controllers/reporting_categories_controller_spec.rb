require 'spec_helper'
require 'rails_helper'

RSpec.describe ReportingCategoriesController, type: :controller do
  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @reporting_category = ReportingCategory.new
        get :new, format: 'js'
      end

      it { expect(assigns[:reporting_category]).to be_a_new(ReportingCategory) }
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
      it 'creates the reporting_category' do
        expect do
          post :create, reporting_category: attributes_for(:reporting_category)
        end.to change(ReportingCategory, :count).by(1)
      end

      it 'redirects to the "show" action for the new reporting_category' do
        post :create, reporting_category: attributes_for(:reporting_category)
        expect(flash[:success]).to eq('Reporting Category was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the reporting_category' do
        expect do
          post :create, reporting_category: attributes_for(:reporting_category, name: nil)
        end.to_not change(ReportingCategory, :count)
      end

      it 're-renders the "new" view' do
        post :create, reporting_category: attributes_for(:reporting_category, name: nil)
        expect(flash[:danger]).to eq('Reporting Category was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
      @reporting_category = FactoryGirl.create(:reporting_category)
    end

    it 'should redirect to index with a notice on successful update' do
      @attr = { name: '1' }
      put :update, id: @reporting_category.id, reporting_category: @attr
      expect(flash[:success]).to eq('Reporting Category was successfully updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { name: nil }
      put :update, id: @reporting_category.id, reporting_category: @attr
      expect(assigns[:reporting_category]).not_to be_new_record
      expect(flash[:danger]).to eq('Reporting Category was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @reporting_category = create(:reporting_category)
        delete :destroy, id: @reporting_category.id
      end

      it { expect(assigns(:reporting_category).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to :back }
    end
  end
end
