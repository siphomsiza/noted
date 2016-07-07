require 'spec_helper'
require 'rails_helper'

RSpec.describe DepartmentsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
        end
      end
        describe "#edit" do
          context "when user is logged in" do

                before do
                  @user = create(:user)
                  @department = create(:department)
                  session[:user_id] = @user.id
                  get :edit,{:id=>@department.id}
                end
                it {expect(response.status).to eq(200) }
                it {expect(response.content_type).to eq("text/html") }
                it {expect(response).to render_template("edit")}
              end
        end
        describe "#create" do
          context "when user is logged in" do

                before do
                  @user = create(:user)
                  session[:user_id] = @user.id
                  @department = create(:department)
                  get :new
                end
                xit "" do
                  post :create
                end
                it {expect(response.status).to eq(200) }
                it {expect(response.content_type).to eq("text/html") }
                xit {expect(response).to render_template("create")}
              end
        end

        describe "#new" do
          context "when user is logged in and is admin" do

                before do
                  @user = create(:user)
                  session[:user_id] = @user.id
                  get :new
                end
                it {expect(response.status).to eq(200) }
                it {expect(response.content_type).to eq("text/html") }
                it {expect(response).to render_template("new")}
              end
        end

        describe "#update" do
          context "when user is logged in" do
                before do
                  @user = create(:user)
                  session[:user_id] = @user.id
                  @department = create(:department)

                end
                xit "" do
                  put :update
                end
                it {expect(response.status).to eq(200) }
                xit {expect(response.content_type).to eq("text/html") }
                xit {flash[:success].should eq("Department was successfully updated.")}
                xit {expect(response).to redirect_to("/departments")}
              end
        end

        describe "Get destroy" do
          context "when user is logged in" do
                before do
                  @user = create(:user)
                  session[:user_id] = @user.id
                  @department = create(:department)
                  get :destroy,:id=>@department.id
                end

                xit {assigns(:department).to eq(@department)}
                xit {expect(response.status).to eq(200) }
                it {expect(response.content_type).to eq("text/html") }
                it {flash[:success].should eq("Department was successfully deleted.")}
                it {expect(response).to redirect_to("/departments")}
              end
        end
        context "when user is not logged in" do
          before do
            get :index
          end
          it {expect(response).to redirect_to(login_path)}
          it {flash[:danger].should eq("Please log in.")}
        end


    context "when user is not logged in" do
      before do
        get :index
      end
      it {expect(response).to redirect_to(login_path)}
      it {flash[:danger].should eq("Please log in.")}
    end

    

    #def log_in(user)
    #  post login_path, :email=> user.email, :password=> user.password
    #end
end
