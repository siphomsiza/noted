require 'spec_helper'
require 'rails_helper'

RSpec.describe SdbipReportsController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
              @sdbip_report = create(:sdbip_report)
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @sdbip_report" do
            sdbip_reports = SdbipReport.all
            expect(:sdbip_reports).to be_truthy
            end


            it "assigns @sdbip_report" do
            sdbip_reports = SdbipReport.new
            expect(sdbip_report).to be_a_new(SdbipReport)
            end

            it {expect(response.status).to eq(200) }
            it {expect(response.content_type).to eq("text/html") }
            it {expect(response).to render_template("index")}
      end
    end

describe "GET#new" do

       let(:sdbip_report_double) { double("sdbip_report_double")}
       before(:each) do
       Item.stub(:new).and_return(sdbip_report_double)
          get :new
        end

       it "creates a new sdbip_report" do
       expect(assigns(:sdbip_report)).to be_a_new(SdbipReport)
      end
end

  describe 'POST #create' do

    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end

    context 'with valid attributes' do
      it 'creates the sdbip_report' do
        post :create, sdbip_report: attributes_for(:sdbip_report)
        expect(SdbipReport.count).to eq(1)
      end

      it 'redirects to the "show" action for the new sdbip_report' do
        post :create, sdbip_report: attributes_for(:sdbip_report)
        expect(response).to redirect_to new_sdbip_report_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create the sdbip_report' do
        post :create, sdbip_report: attributes_for(:sdbip_report, proof_of_evidence: nil)
        expect(SdbipReport.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, sdbip_report: attributes_for(:sdbip_report, proof_of_evidence: nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do

          before(:each) do
              @sdbip_report = FactoryGirl.create(:sdbip_report)
              request.env['HTTP_REFERER'] = root_url
          end

          it "should re-render edit template on failed update" do
          @attr = { :proof_of_evidence => "Billing Report"}
          put :update, :id => @sdbip_report.id, :sdbip_report => @attr
          expect(flash[:success]).to eq("SDBIP report was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :proof_of_evidence => "Report"}
          put :update, :id => @sdbip_report.id, :sdbip_report => @attr
          expect(assigns[:sdbip_report]).not_to be_new_record
          expect(flash[:success]).not_to eq("SDBIP report was not updated.")
          expect(response).to redirect_to new_sdbip_report_path
          end
  end


end