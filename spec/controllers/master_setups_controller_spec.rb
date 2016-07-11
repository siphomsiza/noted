require 'spec_helper'
require 'rails_helper'

RSpec.describe MasterSetupsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              user = create(:user)
              log_in(user)
              get :index
          end
          xit {expect(response.status).to eq(200) }
          xit {expect(response.content_type).to eq("text/html") }
          xit {expect(response).to render_template("index")}
        end
      end
        describe "#edit" do
          context "when user is logged in" do

                before do
                  user = create(:user)
                  log_in(user)
                  get :edit,{:id=>1}
                end
                xit {expect(response.status).to eq(200) }
                xit {expect(response.content_type).to eq("text/html") }
                xit {expect(response).to render_template("edit")}
              end
        end
        describe "#create" do
          context "when user is logged in" do

                before do
                  user = create(:user)
                  log_in(user)
                  get :new
                end
                xit {expect(response.status).to eq(200) }
                xit {expect(response.content_type).to eq("text/html") }
                xit {expect(response).to render_template("create")}
              end
        end

        describe "#new" do
          context "when user is logged in and is admin" do

                before do
                  user = create(:user)
                  log_in(user)
                  get :new
                end
                xit {expect(response.status).to eq(200) }
                xit {expect(response.content_type).to eq("text/html") }
                xit {expect(response).to render_template("new")}
              end
        end

        describe "#update" do
          context "when user is logged in" do

                before do
                  user = create(:user)
                  log_in(user)
                  get :edit,{:id=>1}
                end
                xit {expect(response.status).to eq(200) }
                xit {expect(response.content_type).to eq("text/html") }
                xit {expect(response).to render_template("update")}
              end
        end

        describe "Get destroy" do
          context "when user is logged in" do

                before do
                  user = create(:user)
                  log_in(user)
                  get :destroy, {:id=> 1}
                end
                xit {expect(response.status).to eq(200) }
                xit {expect(response.content_type).to eq("text/html") }
                xit {expect(response).to render_template(:index)}
              end
        end


    context "when user is not logged in" do
      before do
        get :index
      end
      xit {expect(response).to redirect_to(login_path)}
      xit {expect(flash[:danger]).to eq("Please log in.")}
    end



    #def log_in(user)
    #  post login_path, :email=> user.email, :password=> user.password
    #end
end
