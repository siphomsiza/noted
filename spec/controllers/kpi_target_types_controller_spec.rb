require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiTargetTypesController, :type => :controller do
    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @kpi_target_type = KpiTargetType.new
              get :new, :format => 'js'
          end

          it {expect(assigns[:kpi_target_type]).to be_a_new(KpiTargetType)}
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
      it 'creates the kpi_target_type' do
        expect{
					post :create, kpi_target_type: attributes_for(:kpi_target_type)
				}.to change(KpiTargetType,:count).by(1)
      end

      it 'redirects index action' do
        post :create, kpi_target_type: attributes_for(:kpi_target_type)
				expect(flash[:success]).to eq("KPI Target Type was successfully created.")
				expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the kpi_target_type' do
				expect{
					post :create, kpi_target_type: attributes_for(:kpi_target_type, name: nil)
				}.to_not change(KpiTargetType,:count)
      end

      it 'redirects to index' do
        post :create, kpi_target_type: attributes_for(:kpi_target_type, name: nil)
				expect(flash[:danger]).to eq("KPI Target Type was not created.")
				expect(response).to redirect_to :back
      end
    end
  end


  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @kpi_target_type = FactoryGirl.create(:kpi_target_type)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => nil, :code => nil}
          put :update, :id => @kpi_target_type.id, :kpi_target_type => @attr
          expect(flash[:danger]).to eq("KPI Target Type was not updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "Number", :code => "R"}
          put :update, :id => @kpi_target_type.id, :kpi_target_type => @attr
          expect(assigns[:kpi_target_type]).not_to be_new_record
          expect(flash[:success]).to eq("KPI Target Type was successfully updated.")
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
