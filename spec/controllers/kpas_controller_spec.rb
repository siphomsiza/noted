require 'spec_helper'
require 'rails_helper'

RSpec.describe KpasController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               @kpa = create(:kpa)
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @kpa" do
            kpa = Kpa.all
            expect(:kpa).to be_truthy
            end

            it {expect(response.status).to eq(200) }
            it {expect(response.content_type).to eq("text/html") }
            it {expect(response).to render_template("index")}
      end
    end

    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              kpa = Kpa.new
              get :new, :format => 'js'
          end

          it {expect(assigns[:kpa]).to be_a_new(Kpa)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end
  end

  describe 'POST #create' do

    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context 'with valid attributes' do
      it 'creates the kpa' do
        post :create, kpa: attributes_for(:kpa)
        expect(Kpa.count).to eq(1)
      end

      it 'redirects to the "show" action for the new kpa' do
        post :create, kpa: attributes_for(:kpa)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpa' do
        post :create, kpa: attributes_for(:kpa, name: nil)
        expect(Kpa.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, kpa: attributes_for(:kpa, name: nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do

          before(:each) do
              @kpa = FactoryGirl.create(:kpa)
              request.env['HTTP_REFERER'] = root_url
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "Basic Service Delivery", :code => "3"}
          put :update, :id => @kpa.id, :kpa => @attr
          expect(flash[:success]).to eq("KPA was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "Service Delivery", :code => "3"}
          put :update, :id => @kpa.id, :kpa => @attr
          expect(assigns[:kpa]).not_to be_new_record
          expect(flash[:success]).not_to eq("KPA was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before(:each) do 
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @kpa = create(:kpa)
              delete :destroy,:id=>@kpa.id
          end

          it {expect(assigns(:kpa).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end


end