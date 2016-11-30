require 'spec_helper'
require 'rails_helper'

RSpec.describe MasterSetupsController, :type => :controller do
  before(:each) do
    request.env['HTTP_REFERER'] = root_url
      get :index
  end
  describe "GET index" do
    context "when user is admin and logged in" do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @job_titles = Jobtitle.all
        @jobtitle = Jobtitle.new
        @master_setup = MasterSetup.new
        @areas = Area.all
        get :index
      end
          it "assigns @master_setups" do
          master_setups = MasterSetup.all
          expect(master_setups).to be_truthy
          end
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
        end
  end

  describe "#create" do
    before do
      @user = create(:user)
      session[:user_id] = @user.id
      request.env['HTTP_REFERER'] = root_url
    end
    context 'with valid attributes' do
      it 'creates the master_setup' do
        expect do
          post :create, master_setup: attributes_for(:master_setup)
        end.to change(MasterSetup, :count).by(1)
      end

      it 'redirects to the index action' do
        post :create, master_setup: attributes_for(:master_setup)
        expect(flash[:success]).to eq("Master setup was successfully saved.")
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the master_setup' do
        expect do
          post :create, master_setup: attributes_for(:master_setup, municipality: nil)
        end.to_not change(MasterSetup, :count)
      end

      it 'redirects to the previous page' do
        post :create, master_setup: attributes_for(:master_setup, municipality: nil)
        expect(flash[:danger]).to eq("Master setup was not saved.")
        expect(response).to redirect_to :back
      end
    end
  end

  describe "PATCH #update" do
    before do
      @user = create(:user)
      session[:user_id] = @user.id
      request.env['HTTP_REFERER'] = root_url
      @master_setup = FactoryGirl.create(:master_setup)
    end
    it 'should redirect to index with a notice on successful update' do
      @attr = { municipality: 'Waste Management' }
      patch :update, id: @master_setup.id, master_setup: @attr
      expect(flash[:success]).to eq('Master setup was successfully saved.')
      expect(response).to redirect_to :back
    end

    it 'should redirect to index with a notice on unsuccessful update' do
      @attr = { municipality: nil }
      patch :update, id: @master_setup.id, master_setup: @attr
      expect(assigns[:master_setup]).not_to be_new_record
      expect(flash[:danger]).to eq('Master setup was not saved.')
      expect(response).to redirect_to :back
    end
  end
  describe "delete#destroy" do
    context "when user is logged in" do

          before do
          @user = create(:user)
          session[:user_id] = @user.id
          @master_setup = create(:master_setup)
          delete :destroy,:id=>@master_setup.id
          end

          it {expect(assigns(:master_setup).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(flash[:success]).to eq("Master setup was successfully deleted.") }
          it {expect(response).to redirect_to :back}
    end
  end
end
