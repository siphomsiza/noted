require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiOwnersController, :type => :controller do

    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_owner = KpiOwner.new
              get :new, :format => 'js'
          end

          it {expect(assigns[:kpi_owner]).to be_a_new(KpiOwner)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template("new")}
    end
  end

  describe 'POST #create' do
    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context 'with valid attributes' do
      it 'creates the kpi_owner' do
        expect{
					post :create, kpi_owner: attributes_for(:kpi_owner)
				}.to change(KpiOwner,:count).by(1)
      end

      it 'redirects to the "show" action for the new kpi_owner' do
        post :create, kpi_owner: attributes_for(:kpi_owner)
				expect(flash[:success]).to eq("KPI Owner was successfully created.")
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpi_owner' do
				expect{
					post :create, kpi_owner: attributes_for(:kpi_owner, name: nil)
				}.to_not change(KpiOwner,:count)
      end

      it 're-renders the "new" view' do
        post :create, kpi_owner: attributes_for(:kpi_owner, name: nil)
				expect(flash[:danger]).to eq("KPI Owner was not created.")
				expect(response).to redirect_to :back
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @kpi_owner = FactoryGirl.create(:kpi_owner)
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :user_id => "1", :name => "Senior Manager Electricy Services", :can_update => false}
          put :update, :id => @kpi_owner.id, :kpi_owner => @attr
          expect(flash[:success]).to eq("KPI Owner was successfully saved.")
					expect(response).to redirect_to :back
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :user_id => "2", :name => nil, :can_update => false}
          put :update, :id => @kpi_owner.id, :kpi_owner => @attr
          expect(assigns[:kpi_owner]).not_to be_new_record
          expect(flash[:danger]).to eq("KPI Owner was not saved.")
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
