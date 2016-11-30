require 'spec_helper'
require 'rails_helper'

RSpec.describe TopLayerAdministratorsController, :type => :controller do
	
	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               @top_layer_administrator = create(:top_layer_administrator)
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @top_layer_administrator" do
            top_layer_administrator = TopLayerAdministrator.new
            expect(top_layer_administrator).to be_a_new(TopLayerAdministrator)
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
  describe 'POST #create' do
		before do
				@top_layer_administrator = FactoryGirl.create(:top_layer_administrator)
	        @user = create(:user)
	        session[:user_id] = @user.id
		end
    context 'with valid attributes' do
      it 'creates the top_layer_administrator' do
        expect{
					post :create, top_layer_administrator: attributes_for(:top_layer_administrator)
				}.to change(TopLayerAdministrator,:count).by(1)
      end

      it 'redirects to the "show" action for the new top_layer_administrator' do
        post :create, top_layer_administrator: attributes_for(:top_layer_administrator)
				expect(flash[:success]).to eq("Top layer administrator was successfully created.")
        expect(response).to redirect_to top_layer_administrators_url
      end
    end

    context 'with invalid attributes' do
      it 'does not create the top_layer_administrator' do
				expect{
					post :create, top_layer_administrator: attributes_for(:top_layer_administrator, user_id: nil)
				}.to_not change(TopLayerAdministrator,:count)
      end

      it 're-renders the "new" view' do
        post :create, top_layer_administrator: attributes_for(:top_layer_administrator, user_id: nil)
				expect(flash[:danger]).to eq("Top layer administrator was not created.")
				expect(response).to redirect_to top_layer_administrators_url
      end
    end
  end

  describe "#update" do

          before(:each) do
              @top_layer_administrator = FactoryGirl.create(:top_layer_administrator)
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :departmental_id => "2", :user_id => "2", :can_create => false, :can_edit => false}
          put :update, :id => @top_layer_administrator.id, :top_layer_administrator => @attr
          expect(flash[:success]).to eq("Top layer administrator was successfully updated.")
					expect(response).to redirect_to top_layer_administrators_url
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :departmental_id => "1", :user_id => nil, :can_create => false, :can_edit => false}
          put :update, :id => @top_layer_administrator.id, :top_layer_administrator => @attr
          expect(assigns[:top_layer_administrator]).not_to be_new_record
          expect(flash[:danger]).to eq("Top layer administrator was not updated.")
          expect(response).to redirect_to top_layer_administrators_url
          end

  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @top_layer_administrator = create(:top_layer_administrator)
              delete :destroy,:id=>@top_layer_administrator.id
          end

          it {expect(assigns(:top_layer_administrator).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to top_layer_administrators_url}
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
