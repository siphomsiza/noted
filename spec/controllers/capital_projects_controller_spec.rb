require 'spec_helper'
require 'rails_helper'

RSpec.describe CapitalProjectsController, type: :controller do
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

    it 'assigns @capital_projects' do
      capital_projects = CapitalProject.all
      get :index
      expect(capital_projects).to be_truthy
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

  describe 'GET #show' do
    it 'assigns the requested capital_project to @capital_project' do
      @capital_project = FactoryGirl.create(:capital_project)
      get :show, :id => @capital_project.id, :format => 'js'
      expect(assigns(:capital_project)).to eq(@capital_project)
    end

    it { expect(response.status).to eq(200) }
    it { expect(response.content_type).to eq('text/javascript') }
    it { expect(response).to render_template('show') }
  end

  describe '#edit' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        @capital_project = FactoryGirl.create(:capital_project)
        session[:user_id] = @user.id
        get :edit, :id => @capital_project.id, :format => 'js'
      end
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template(:edit) }
    end
    context 'when user is not logged in' do
      before do
        @capital_project = FactoryGirl.create(:capital_project)
        session[:user_id] = nil
        get :edit, :id => @capital_project.id, :format => 'js'
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end
  describe '#edit_capital_projects' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        @capital_project = FactoryGirl.create(:capital_project)
        session[:user_id] = @user.id
        get :edit_capital_projects, :id => @capital_project.id, :format => 'js'
      end
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/javascript') }
      it { expect(response).to render_template(:edit_capital_projects) }
    end
    context 'when user is not logged in' do
      before do
        @capital_project = FactoryGirl.create(:capital_project)
        session[:user_id] = nil
        get :edit_capital_projects, :id => @capital_project.id, :format => 'js'
      end

      it { expect(response).to redirect_to(login_path) }
      it { expect(flash[:danger]).to eq('Please log in.') }
    end
  end

  describe "#create" do
    context "with valid info" do
          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @capital_project = FactoryGirl.create(:capital_project)
              get :index
          end

          it "#save capital_project" do
              expect{
      				post :create, capital_project: attributes_for(:capital_project)
      			}.to change(CapitalProject,:count).by(1)
          end
          it 'redirects to back' do
            post :create, capital_project: attributes_for(:capital_project)
    				expect(flash[:success]).to eq("Capital Project was successfully created.")
            expect(response).to redirect_to :back
          end
    end
    context "with invalid info" do
          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @capital_project = FactoryGirl.create(:capital_project)
              get :index
          end

          it 'does not create the capital_project' do
    				expect{
    				post :create, capital_project: attributes_for(:capital_project,subdepartment_id: nil)
    			}.to_not change(CapitalProject,:count)
          end
    			it 'redirects to back' do
            post :create, capital_project: attributes_for(:capital_project,subdepartment_id: nil)
    				expect(flash[:danger]).to eq("Capital Project was not created.")
            expect(response).to redirect_to :back
          end
    end

    context "when user is not logged in" do

          before do
          session[:user_id] = nil
          get :index
          end
          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#update" do
          before do
              request.env['HTTP_REFERER'] = root_url
              @capital_project = FactoryGirl.create(:capital_project)
              @user = FactoryGirl.create(:user)
              session[:user_id] = @user.id
              get :edit, :id => @capital_project.id, :format => 'js'
          end
          it "should redirect to index with a notice on successful update" do
          @attr = { :subdepartment_id => 2}
          patch :update, :id => @capital_project.id, :capital_project => @attr
          expect(assigns[:capital_project]).not_to be_new_record
          expect(flash[:success]).to eq("Capital Project was successfully updated.")
          expect(response).to redirect_to  :back
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :subdepartment_id => nil}
          patch :update, :id => @capital_project.id, :capital_project => @attr
          expect(assigns[:capital_project]).not_to be_new_record
          expect(flash[:danger]).to eq("Capital Project was not updated.")
          expect(response).to redirect_to :back
          end

    context "when user is not logged in" do
          before do
            @capital_project = FactoryGirl.create(:capital_project)
            session[:user_id] = nil
            get :edit, :id => @capital_project.id, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe '#new' do
    context 'when user is logged in and is admin' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @capital_project = FactoryGirl.create(:capital_project)
        get :new
      end

      it { expect(assigns[:capital_project]).to be_a_new(CapitalProject) }
      it { expect(response.status).to eq(200) }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to render_template('new') }
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

  describe 'POST #import' do
    it 'redirects to the home page' do
      allow(CapitalProject).to receive(:import).with('foo.txt')
      post :import, file: 'foo.txt'
      expect(response).to redirect_to capital_projects_url
    end

    it 'adds a flash success' do
      allow(CapitalProject).to receive(:import).with('foo.txt')
      post :import, file: 'foo.txt'
      expect(flash[:success]).to eq 'Capital Projects imported successfully.'
      expect(response).to redirect_to capital_projects_url
    end

    it 'adds a flash danger message' do
      allow(CapitalProject).to receive(:import).with('foo.txt')
      post :import, file: nil
      expect(flash[:danger]).to eq 'You have not selected a file'
      expect(response).to redirect_to capital_projects_url
    end

    it 'imports the capital_project file' do
      #expect(CapitalProject).to receive(:import).with(File.open(File.join(Rails.root, '/spec/data', 'capital_project.csv')))
      post :import, file: File.open(File.join(Rails.root, '/spec/data', 'capital_project.csv'))
      expect(flash[:danger]).to eq 'Capital Projects failed to import.'
      expect(response).to redirect_to capital_projects_url
    end
  end

  describe 'delete#destroy' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
        @capital_project = FactoryGirl.create(:capital_project)
        delete :destroy, :id => @capital_project.id
      end

      it { expect(assigns(:capital_project).destroyed?).to be true }
      it { expect(response.content_type).to eq('text/html') }
      it { expect(response).to redirect_to capital_projects_url }
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
