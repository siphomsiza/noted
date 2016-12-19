require 'spec_helper'
require 'rails_helper'

RSpec.describe SetupsController, type: :controller do
  describe 'GET index' do
    context 'when user is admin and logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        get :index
      end
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('index') }
    end

    it 'assigns @setup' do
      @setup = Setup.new
    end

    it 'assigns @top_layer_sdbips' do
      setups = Setup.all
      expect(setups).to be_truthy
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
    context 'when user is logged in' do
      before do
        @user = create(:user)
        session[:setup_id] = @user.id
        expect { post :create, setup: attributes_for(:setup) }.to change(Setup, :count).by(1)
      end

      it 'creates setup' do
        post :create, setup: attributes_for(:setup)
        @setup = assigns(:setup)
      end
      it { expect(flash[:success]).to eq('Setup saved successfully.') }
      it { expect(response).to redirect_to setups_path }
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
  describe '#edit' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        @setup = create(:setup)
        session[:user_id] = @user.id
        get :edit, :id => @setup.id, :format => 'js'
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template('edit') }
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

  describe '#update' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @setup = Setup.create!(performance_comments: true)
      end
      it 'should redirect to index with a notice on successful update' do
        @attr = { performance_comments: true }
        patch :update, id: @setup.id, setup: @attr
        expect(flash[:success]).to eq('Setup was successfully updated.')
        expect(response).to redirect_to setups_path
      end
    end
  end

  describe 'Get destroy' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @setup = create(:setup)
        get :destroy, id: @setup.id
      end

      it { expect(response.content_type).to eq('text/html') }
      it { expect(assigns(:setup).destroyed?).to be true }
      it { expect(response).to redirect_to setups_path }
    end

    context 'when user is not logged in' do
      before do
        get :index
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end
end
