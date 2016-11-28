require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiConceptsController, :type => :controller do
    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_concept = KpiConcept.new
              get :new, :format => 'js'
          end

          it {expect(assigns[:kpi_concept]).to be_a_new(KpiConcept)}
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
      it 'creates the kpi_concept' do
        expect{
				post :create, kpi_concept: attributes_for(:kpi_concept)
			}.to change(KpiConcept,:count).by(1)
      end

      it 'redirects to back' do
        post :create, kpi_concept: attributes_for(:kpi_concept)
				expect(flash[:success]).to eq("KPI Concept was successfully created.")
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpi_concept' do
				expect{
				post :create, kpi_concept: attributes_for(:kpi_concept,name: nil)
			}.to_not change(KpiConcept,:count)
      end
			it 'redirects to back' do
        post :create, kpi_concept: attributes_for(:kpi_concept,name: nil)
				expect(flash[:danger]).to eq("KPI Concept was not created.")
        expect(response).to redirect_to :back
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @kpi_concept = FactoryGirl.create(:kpi_concept)
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "CRR"}
          put :update, :id => @kpi_concept.id, :kpi_concept => @attr
					expect(assigns[:kpi_concept]).not_to be_new_record
          expect(flash[:success]).to eq("KPI Concept was successfully updated.")
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :name => nil}
          put :update, :id => @kpi_concept.id, :kpi_concept => @attr
          expect(assigns[:kpi_concept]).not_to be_new_record
          expect(flash[:danger]).to eq("KPI Concept was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_concept = create(:kpi_concept)
              delete :destroy,:id=>@kpi_concept.id
          end

          it {expect(assigns(:kpi_concept).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end

end
