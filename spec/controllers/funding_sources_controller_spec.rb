require 'spec_helper'
require 'rails_helper'

RSpec.describe FundingSourcesController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               funding_source = FundingSource.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @funding_source" do
            funding_sources = FundingSource.all
            expect(:funding_source).to be_truthy
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
              funding_source = FundingSource.new
              get :new, @params, :format => 'js'
          end

          it {expect(assigns[:funding_source]).to be_a_new(FundingSource)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("funding_sources/new")}
    end
  end

  describe 'POST #create' do

    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end

    context 'with valid attributes' do
      it 'creates the funding_source' do
        post :create, funding_source: attributes_for(:funding_source)
        expect(FundingSource.count).to eq(1)
        expect(assigns(:funding_source)).to be_a(FundingSource)
        expect(assigns(:funding_source)).to be_persisted
      end

      it 'redirects to the "show" action for the new funding_source' do
        post :create, funding_source: attributes_for(:funding_source)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the funding_source' do
        post :create, funding_source: attributes_for(:funding_source, name: nil)
        expect(FundingSource.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, funding_source: attributes_for(:funding_source, name: nil)
        
      end
    end
  end

  describe "#update" do

          before(:each) do
              @funding_source = FactoryGirl.create(:funding_source)
              request.env['HTTP_REFERER'] = root_url
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "CRR"}
          put :update, :id => @funding_source.id, :funding_source => @attr
          expect(flash[:success]).to eq("Funding source was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "MIG"}
          put :update, :id => @funding_source.id, :funding_source => @attr
          expect(assigns[:funding_source]).not_to be_new_record
          expect(flash[:success]).not_to eq("Funding source was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @funding_source = create(:funding_source)
              delete :destroy,:id=>@funding_source.id
          end

          it {expect(assigns(:funding_source).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end


end