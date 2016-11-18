require 'spec_helper'
require 'rails_helper'

RSpec.describe AreasController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               area = Area.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @wards" do
            ward = Ward.create
            expect(assigns(:area)).to be_nil
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
              area = Area.create
              get :new
          end

          it {expect(assigns[:area]).to be_a_new(Area)}
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
      it 'creates the area' do
        post :create, area: attributes_for(:area)
        expect(Area.count).to eq(2)
      end

      it 'redirects to the "show" action for the new area' do
        post :create, area: attributes_for(:area)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the area' do
        post :create, area: attributes_for(:area, name: nil)
        expect(Area.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, area: attributes_for(:area, name: nil)
      end
    end
  end

  describe "#update" do

          before(:each) do
              @area = FactoryGirl.create(:area)
              request.env['HTTP_REFERER'] = root_url
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => ""}
          put :update, :id => @area.id, :area => @attr
          expect(flash[:danger]).to eq("Area was not updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "Piet Retief"}
          put :update, :id => @area.id, :area => @attr
          expect(assigns[:area]).not_to be_new_record
          expect(flash[:success]).to eq("Area was successfully updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @area = create(:area)
              delete :destroy,:id=>@area.id
          end

          it {expect(assigns(:area).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end

end
