require 'spec_helper'
require 'rails_helper'

RSpec.describe ListsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @list = create(:list)
              session[:list_id] = @list.id
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
                @list = create(:list)
                session[:user_id] = @user.id
                get :edit,{:id=>@list.id}
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
                  @list = create(:list)
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
                  @list = create(:list)
                  session[:list_id] = @list.id
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
                  @list = create(:list)

                end
                xit "" do
                  put :update
                end
                it {expect(response.status).to eq(200) }
                xit {expect(response.content_type).to eq("text/html") }
                xit {expect(flash[:success]).to eq("list sdbip was successfully updated.")}
                xit {expect(response).to redirect_to("/list")}
              end
        end

        describe "Get destroy" do
          context "when user is logged in" do
                before do
                  @user = create(:user)
                  session[:user_id] = @user.id
                  @list = create(:list)
                  get :destroy,:id=>@list.id
                end

                xit {assigns(:list).to eq(@list)}
               xit {expect(response.status).to eq(200) }
               xit {expect(response.content_type).to eq("text/html") }
                xit {expect(flash[:success]).to eq("list sdbip was successfully deleted.")}
                xit {expect(response).to redirect_to("/lists")}
              end
        end


    context "when user is not logged in" do
      before do
        get :index
      end
      xit {expect(response).to redirect_to(login_path)}
      xit {expect(flash[:success]).to eq("Please log in.")}
    end



    #def log_in(user)
    #  post login_path, :email=> user.email, :password=> user.password
    #end
end
