require 'spec_helper'
require 'rails_helper'

RSpec.describe MtasIndicatorsController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               mtas_indicator = MtasIndicator.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @kpi_calculation_type" do
            mtas_indicators = MtasIndicator.all
            expect(mtas_indicators).to be_truthy
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
              mtas_indicator = MtasIndicator.new
              get :new
          end

          it {expect(assigns[:mtas_indicator]).to be_a_new(MtasIndicator)}
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
      it 'creates the mtas_indicator' do
        post :create, mtas_indicator: attributes_for(:mtas_indicator)
        expect(MtasIndicator.count).to eq(1)
      end

      it 'redirects to the "show" action for the new mtas_indicator' do
        post :create, mtas_indicator: attributes_for(:mtas_indicator)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the mtas_indicator' do
        post :create, mtas_indicator: attributes_for(:mtas_indicator, name: nil)
        expect(MtasIndicator.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, mtas_indicator: attributes_for(:mtas_indicator, name: nil)
        
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @mtas_indicator = FactoryGirl.create(:mtas_indicator)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "% of projects completed on time and meeting specifications(quality assessment)"}
          put :update, :id => @mtas_indicator.id, :mtas_indicator => @attr
          expect(flash[:success]).to eq("Mtas indicator was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "Number of dedicated officer located in both centres"}
          put :update, :id => @mtas_indicator.id, :mtas_indicator => @attr
          expect(assigns[:mtas_indicator]).not_to be_new_record
          expect(flash[:success]).not_to eq("Mtas indicator was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @mtas_indicator = create(:mtas_indicator)
              delete :destroy,:id=>@mtas_indicator.id
          end

          it {expect(assigns(:mtas_indicator).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end

end