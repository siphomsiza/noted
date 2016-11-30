require 'spec_helper'
require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
  describe 'GET index' do
    context 'when user is admin and logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @department = Department.new
        get :index
      end

      it { expect(assigns(:department)).to be_a_new(Department) }
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('index') }
    end
  end

  describe 'POST #create' do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end
    context 'with valid attributes' do
      it 'creates the department' do
        expect do
          post :create, department: attributes_for(:department)
        end.to change(Department, :count).by(1)
      end

      it 'redirects to the "show" action for the new department' do
        post :create, department: attributes_for(:department)
        expect(flash[:success]).to eq('Department record was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the department' do
        expect do
          post :create, department: attributes_for(:department, name: nil)
        end.to_not change(Department, :count)
      end

      it 'redirects to the previous page' do
        post :create, department: attributes_for(:department, name: nil)
        expect(flash[:danger]).to eq('Department record was not created.')
        expect(response).to redirect_to :back
      end
    end
  end

  describe '#update' do
    before(:each) do
      @user = create(:user)
      session[:user_id] = @user.id
      @department = FactoryGirl.create(:department)
    end
    it 'should redirect to index with a notice on successful update' do
      @attr = { name: 'Waste Management' }
      patch :update, id: @department.id, department: @attr
      expect(flash[:success]).to eq('Department record was successfully updated.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { name: nil }
      patch :update, id: @department.id, department: @attr
      expect(flash[:danger]).to eq('Department record was not updated.')
      expect(response).to redirect_to :back
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        request.env['HTTP_REFERER'] = root_url
        @user = create(:user)
        session[:user_id] = @user.id
        @department = FactoryGirl.create(:department)
        delete :destroy, id: @department.id
      end

      it { expect(delete(:destroy, id: @department.id)) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(flash[:success]).to eq('Department record was successfully deleted.') }
      it { expect(response).to redirect_to departments_path }
    end
  end
  describe 'not logged in' do
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
