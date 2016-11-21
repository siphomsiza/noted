require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiOwnersController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               @kpi_owner = create(:kpi_owner)
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @kpi_calculation_type" do
            kpi_owners = KpiOwner.all
            expect(kpi_owners).to be_truthy
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
              kpi_owner = KpiOwner.new
              get :new
          end

          it {expect(assigns[:kpi_owner]).to be_a_new(KpiOwner)}
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
      it 'creates the kpi_owner' do
        post :create, kpi_owner: attributes_for(:kpi_owner)
        expect(KpiOwner.count).to eq(1)
      end

      it 'redirects to the "show" action for the new kpi_owner' do
        post :create, kpi_owner: attributes_for(:kpi_owner)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpi_owner' do
        post :create, kpi_owner: attributes_for(:kpi_owner, user_id: nil)
        expect(KpiOwner.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, kpi_owner: attributes_for(:kpi_owner, user_id: nil)
        
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @kpi_owner = FactoryGirl.create(:kpi_owner)
          end

          it "should re-render edit template on failed update" do
          @attr = { :user_id => "1", :name => "Senior Manager Electricy Services", :can_update => false}
          put :update, :id => @kpi_owner.id, :kpi_owner => @attr
          expect(flash[:success]).to eq("Kpi Owner was successfully saved.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :user_id => "2", :name => "Senior Manager Electricy Services", :can_update => false}
          put :update, :id => @kpi_owner.id, :kpi_owner => @attr
          expect(assigns[:kpi_owner]).not_to be_new_record
          expect(flash[:success]).not_to eq("Kpi Owner was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_owner = create(:kpi_owner)
              delete :destroy,:id=>@kpi_owner.id
          end

          it {expect(assigns(:kpi_owner).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end

end