require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiCalculationTypesController, :type => :controller do
    describe "#new" do
    context "when user is logged in and is admin" do
          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_calculation_type = KpiCalculationType.new
              get :new, :format => 'js'
          end

          it {expect(assigns[:kpi_calculation_type]).to be_a_new(KpiCalculationType)}
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
      it 'creates the kpi_calculation_type' do
        expect{
					post :create, kpi_calculation_type: attributes_for(:kpi_calculation_type)
				}.to change(KpiCalculationType,:count).by(1)
      end

      it 'redirects to the "show" action for the new kpi_calculation_type' do
        post :create, kpi_calculation_type: attributes_for(:kpi_calculation_type)
				expect(flash[:success]).to eq("KPI Calculation Type was successfully created.")
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpi_calculation_type' do
				expect{
					post :create, kpi_calculation_type: attributes_for(:kpi_calculation_type, name: nil)
				}.to_not change(KpiCalculationType,:count)
				expect(flash[:danger]).to eq("KPI Calculation Type was not created.")
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @kpi_calculation_type = FactoryGirl.create(:kpi_calculation_type)
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "CRR"}
          put :update, :id => @kpi_calculation_type.id, :kpi_calculation_type => @attr
          expect(flash[:success]).to eq("KPI Calculation Type was successfully updated.")
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => nil}
          put :update, :id => @kpi_calculation_type.id, :kpi_calculation_type => @attr
          expect(assigns[:kpi_calculation_type]).not_to be_new_record
          expect(flash[:danger]).to eq("KPI Calculation Type was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_calculation_type = create(:kpi_calculation_type)
              delete :destroy,:id=>@kpi_calculation_type.id
          end

          it {expect(assigns(:kpi_calculation_type).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end
end
