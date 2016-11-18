require 'spec_helper'
require 'rails_helper'

RSpec.describe MasterSetupsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end
          it "assigns @jobtitle" do
          jobtitle = Jobtitle.create
          get :index
          expect(assigns[:jobtitle]).to be_nil
          end

          it "assigns @job_title" do
          job_titles = Jobtitle.all
          get :index
          expect(assigns(:job_title)).to eq(@job_title)
          end

          it "assigns @master_setups" do
          master_setup = MasterSetup.create
          get :index
          expect {(assigns[:master_setup]).to eq(MasterSetup(master_setup_params)) }
          end

          it "assigns @master_setups" do
          master_setups = MasterSetup.all
          get :index
          expect(master_setups).to be_truthy
          end
  end

  describe "#create" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @master_setup = create(:master_setup)
              
              get :index
          end

          it "#save master_setup" do
          master_setup_params = FactoryGirl.attributes_for(:master_setup)
          expect {(assigns[:master_setup]).to eq(MasterSetup(master_setup_params)) }
          expect { post :create, :master_setup => master_setup_params }.to change(MasterSetup, :count).by(1) 
          end

          it { expect(response).to have_http_status(200)}
    end
  end

  describe "#new" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @master_setup = create(:master_setup)
              get :new
          end

          it {expect(assigns(:master_setup)).to be_a_new(MasterSetup)}
          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end
  end

  describe "PATCH #update" do
    context "with valid params" do

      let(:valid_attributes) {
    { "municipality" => "Mkhondo", "province" => "Gauteng" }
  }

  let(:invalid_attributes) {
    { "municipality" => nil, "province" => "Gauteng" }
  }
      let(:new_attributes) {
        { "municipality" => "Sakhisizwe" }
      }
      let!(:master_setup) { MasterSetup.create(valid_attributes) }

      it "updates the requested master_setup" do
        patch :update, { id: @master_setup.id, :master_setup => FactoryGirl.attributes_for(:master_setup), format: :json  }
        master_setup.reload
        expect(master_setup.municipality).to eq("Sakhisizwe")
      end

      it "assigns the requested master_setup as @master_setup" do
        patch :update, { id: @master_setup.id, :master_setup => FactoryGirl.attributes_for(:master_setup), format: :json  }
        expect(assigns(:master_setup)).to eq(master_setup)
        expect(response).to redirect_to master_setups_url
      end
    end

    context "with invalid params" do
      it "assigns the master_setup as @master_setup" do
        patch :update, { id: @master_setup.id, :master_setup => FactoryGirl.attributes_for(:master_setup), format: :json  }
        expect(assigns(:master_setup)).to eq(master_setup)
      end

      it "returns unprocessable_entity status" do
        patch :update, { id: @master_setup.id, :master_setup => FactoryGirl.attributes_for(:master_setup), format: :json  }
        expect(response.status).to eq(422)
      end
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
          it {expect(response).to redirect_to master_setups_path}
          it {expect(flash[:danger]).to eq("Master setup was successfully deleted.") }
    end
  end

  describe "#set_master_setup" do
    context "when user is logged in" do

          let(:valid_attributes) { { "municipality" => "Mkhondo", "province" => "Gauteng" } }
          let(:valid_session) { {} }

          it "creates a new MasterSetup" do
          expect {
            post :create, {:master_setup => valid_attributes}, valid_session
                 }.to change(MasterSetup, :count).by(1)
          end

          it "assigns a newly created master_setup as @master_setup" do
          post :create, {:master_setup => valid_attributes}, valid_session
          expect(assigns(:master_setup)).to be_a(MasterSetup)
          expect(assigns(:master_setup)).to be_persisted
          end

          it "redirects to the created master_setup" do
          post :create, {:master_setup => valid_attributes}, valid_session
          expect(response).to redirect_to(MasterSetup)
          end
    end
  end
end
