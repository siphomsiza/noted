require 'spec_helper'
require 'rails_helper'

RSpec.describe DepartmentalAdministratorsController, type: :controller do
	before(:each) do
		request.env['HTTP_REFERER'] = root_url
	end
  describe 'GET index' do
    context 'when user is admin and logged in' do
      before do
        @departmental_administrator = DepartmentalAdministrator.create
        @user = create(:user)
        session[:user_id] = @user.id
        get :index
      end

      it 'assigns @top_layer_administrator' do
        top_layer_administrator = TopLayerAdministrator.new
        expect(top_layer_administrator).to be_a_new(TopLayerAdministrator)
      end

      it 'assigns @kpi_owners' do
        kpi_owner = KpiOwner.new
        expect(kpi_owner).to be_a_new(KpiOwner)
      end

      it 'assigns @departmental_administrator' do
        departmental_administrator = DepartmentalAdministrator.new
        expect(departmental_administrator).to be_a_new(DepartmentalAdministrator)
      end

      it 'assigns @subdepartmental_administrator' do
        subdepartmental_administrator = SubdepartmentalAdministrator.new
        expect(subdepartmental_administrator).to be_a_new(SubdepartmentalAdministrator)
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('index') }
    end

    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        get :index
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end
  describe '#create' do
    context 'when user is admin and logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @departmental_administrator = DepartmentalAdministrator.new
        get :index
      end
      it '#save departmental_administrator' do
        departmental_administrator_params = FactoryGirl.attributes_for(:departmental_administrator)
        expect { assigns[:departmental_administrator].to eq(DepartmentalAdministrator(departmental_administrator_params)) }
        expect { post :create, departmental_administrator: departmental_administrator_params }.to change(DepartmentalAdministrator, :count).by(1)
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('departmental_administrators/index') }
    end
    context 'with invalid attributes' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @departmental_administrator = DepartmentalAdministrator.create
        get :index
      end
      it 'does not create the departmental_administrator' do
        expect do
          post :create, departmental_administrator: attributes_for(:departmental_administrator, user_id: nil)
        end.to_not change(DepartmentalAdministrator, :count)
      end

      it 'redirects to the index action for the new national_outcome' do
        post :create, departmental_administrator: attributes_for(:departmental_administrator, user_id: nil)
        expect(flash[:danger]).to eq('Departmental administrator was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      @departmental_administrator = FactoryGirl.create(:departmental_administrator)
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { departmental_id: '1', user_id: nil, can_create: false, can_edit: false }
      patch :update, id: @departmental_administrator.id, departmental_administrator: @attr
      expect(flash[:danger]).to eq('Departmental administrator was not updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on successful update' do
      @attr = { departmental_id: '2', user_id: '1', can_create: false, can_edit: false }
      patch :update, id: @departmental_administrator.id, departmental_administrator: @attr
      expect(assigns[:departmental_administrator]).not_to be_new_record
      expect(flash[:success]).to eq('Departmental administrator was successfully updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @departmental_administrator = create(:departmental_administrator)
        delete :destroy, id: @departmental_administrator.id
      end

      it { expect(assigns(:departmental_administrator).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to departmental_administrators_url }
    end

    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        get :index
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end
end
