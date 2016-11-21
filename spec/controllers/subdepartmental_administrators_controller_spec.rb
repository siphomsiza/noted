require 'spec_helper'
require 'rails_helper'

RSpec.describe SubdepartmentalAdministratorsController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               subdepartmental_administrator = SubdepartmentalAdministrator.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @departmental_administrator" do
            departmental_administrator = SubdepartmentalAdministrator.new
            expect(:departmental_administrator).to include(User, Subdepartment)
            end

            it "assigns @subdepartmental_administrator" do
            subdepartmental_administrator = SubdepartmentalAdministrator.new
            expect(subdepartmental_administrator).to be_a_new(SubdepartmentalAdministrator)
            end

            it {expect(response.status).to eq(200) }
            it {expect(response.content_type).to eq("text/html") }
            it {expect(response).to render_template("index")}
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

    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              subdepartmental_administrator = SubdepartmentalAdministrator.new
              get :new
          end

          it {expect(assigns[:subdepartmental_administrator]).to be_a_new(SubdepartmentalAdministrator)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
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

  describe 'POST #create' do

    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context 'with valid attributes' do
      it 'creates the subdepartmental_administrator' do
        post :create, subdepartmental_administrator: attributes_for(:subdepartmental_administrator)
        expect(SubdepartmentalAdministrator.count).to eq(1)
      end

      it 'redirects to the "show" action for the new subdepartmental_administrator' do
        post :create, subdepartmental_administrator: attributes_for(:subdepartmental_administrator)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the subdepartmental_administrator' do
        post :create, subdepartmental_administrator: attributes_for(:subdepartmental_administrator, name: nil)
        expect(SubdepartmentalAdministrator.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, subdepartmental_administrator: attributes_for(:subdepartmental_administrator, name: nil)
        
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

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @subdepartmental_administrator = FactoryGirl.create(:subdepartmental_administrator)
          end

          it "should re-render edit template on failed update" do
          @attr = { :subdepartmental_id => "0", :user_id => "0", :can_create => false, :can_edit => false}
          put :update, :id => @subdepartmental_administrator.id, :subdepartmental_administrator => @attr
          expect(flash[:success]).to eq("Subdepartmental administrator was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :subdepartmental_id => "1", :user_id => "0", :can_create => false, :can_edit => false}
          put :update, :id => @subdepartmental_administrator.id, :subdepartmental_administrator => @attr
          expect(assigns[:subdepartmental_administrator]).not_to be_new_record
          expect(flash[:success]).not_to eq("Subdepartmental administrator was not updated.")
          expect(response).to redirect_to @subdepartmental_administrator
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

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @subdepartmental_administrator = create(:subdepartmental_administrator)
              delete :destroy,:id=>@subdepartmental_administrator.id
          end

          it {expect(assigns(:subdepartmental_administrator).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
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

end