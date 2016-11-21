require 'spec_helper'
require 'rails_helper'

RSpec.describe DepartmentsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              departments = Department.create
              get :index
          end

          it {expect(assigns(:department)).to be_a_new(Department)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end
  end

  describe "PUT #update" do
    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context "with valid params" do

      let(:valid_attributes) {
    { "name" => "Technical Services", "tel_no" => "1221122", "fax_no" => "67699887" }
  }

  let(:invalid_attributes) {
    { "name" => nil, "tel_no" => "1221122", "fax_no" => "67699887" }
  }
      let(:new_attributes) {
        { "tel_no" => "0353454", "fax_no" => "30393847" }
      }
      let!(:department) { Department.create(valid_attributes) }

      it "updates the requested department" do
        put :update, { id: department.id, department: new_attributes, format: :json  }
        department.reload
        expect(department.tel_no).to eq("0353454")
        expect(department.fax_no).to eq("30393847")
      end

      it "assigns the requested department as @department" do
        put :update, { id: department.id, department: valid_attributes, format: :json  }
        expect(assigns(:department)).to eq(department)
        expect(response).to redirect_to :back
      end
    end

    context "with invalid params" do
      it "assigns the department as @department" do
        put :update, { id: department.id, department: invalid_attributes, format: :json  }
        expect(assigns(:department)).to eq(department)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: department.id, department: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "#edit" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              users = User.all
              @department = create(:department)
              session[:user_id] = @user.id
              get :edit,{:id=>@department.id}
          end

          it {expect(assigns(:user)).to be_nil}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("edit")}
    end
  end

  describe "#create" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              department = Department.create
              get :index
          end

          it "#save department" do
          department_params = FactoryGirl.attributes_for(:department)
          expect {(assigns[:department]).to eq(Department(department_params)) }
          expect { post :create, :department => department_params }.to change(Department, :count).by(1) 
          end

          it { expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("departments/index")}
    end

        end

  describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              users = User.all
              session[:user_id] = @user.id
              departments = Department.create
              get :new
          end

          it {expect(assigns(:user)).to be_nil}
          it {expect(assigns(:department)).to be_a_new(Department)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :new
          end
          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @department = create(:department)
              delete :destroy,:id=>@department.id
          end

          it {expect(assigns(:department).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(flash[:success]).to eq("Department was successfully deleted.")}
          it {expect(response).to redirect_to("/departments")}
    end
  end

    context "when user is not logged in" do
          before do
              get :index
          end
          
          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end