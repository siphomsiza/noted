require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiTargetTypesController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               kpi_target_type = KpiTargetType.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @kpi_calculation_type" do
            kpi_target_types = KpiTargetType.all
            expect(kpi_target_types).to be_truthy
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
              kpi_target_type = KpiTargetType.new
              get :new
          end

          it {expect(assigns[:kpi_target_type]).to be_a_new(KpiTargetType)}
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
      it 'creates the kpi_target_type' do
        post :create, kpi_target_type: attributes_for(:kpi_target_type)
        expect(KpiTargetType.count).to eq(1)
      end

      it 'redirects to the "show" action for the new kpi_target_type' do
        post :create, kpi_target_type: attributes_for(:kpi_target_type)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpi_target_type' do
        post :create, kpi_target_type: attributes_for(:kpi_target_type, name: nil)
        expect(KpiTargetType.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, kpi_target_type: attributes_for(:kpi_target_type, name: nil)
        
      end
    end
  end


  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @kpi_target_type = FactoryGirl.create(:kpi_target_type)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "Currency", :code => "R"}
          put :update, :id => @kpi_target_type.id, :kpi_target_type => @attr
          expect(flash[:success]).to eq("KPI Target Type was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "Number", :code => "R"}
          put :update, :id => @kpi_target_type.id, :kpi_target_type => @attr
          expect(assigns[:kpi_target_type]).not_to be_new_record
          expect(flash[:danger]).not_to eq("KPI Target Type was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_target_type = create(:kpi_target_type)
              delete :destroy,:id=>@kpi_target_type.id
          end

          it {expect(assigns(:kpi_target_type).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end

end