require 'spec_helper'
require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "#introduction" do
    context "when user is logged in" do
          before do
              user = create(:user)
              session[:user_id] = user.id
              get :introduction
          end
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("introduction")}
    end
    context "when user is not logged in" do
          before do
              session[:user_id] = nil
              get :introduction
          end
          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#help" do
    context "" do
          before do
              get :help
          end
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("help")}
    end
  end

  describe "#contact" do
    context "" do
          before do
              get :contact
          end
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("contact")}
    end
  end

    describe "#about" do
      context "when user is logged in" do
            before do
                user = create(:user)
                session[:user_id] = user.id
                get :about
            end
            it {expect(response.status).to eq(200) }
            it {expect(response.content_type).to eq("text/html") }
            it {expect(response).to render_template("about")}
        end
      context "when user is not logged in" do
              before do
                  session[:user_id] = nil
                  get :about
              end
              it {expect(response.content_type).to eq("text/html") }
              it {expect(response).to redirect_to(login_url)}
          end
      end

  describe "#setup" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :setup
          end

          it "assigns @setups" do
          setups = Setup.all
          expect(setups).to be_truthy
          end

          it "assigns @departments" do
          departments = Department.all
          expect(departments).to be_truthy
          end

          it "assigns @headings" do
          headings = Heading.all
          get :setup
          expect(headings).to be_truthy
          end

          it "assigns @roles" do
          roles = Role.all
          expect(roles).to be_truthy
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("setup")}
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :setup
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#dashboard" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :dashboard
          end

          it "assigns @sdbip_time_periods" do
          sdbip_time_periods = SdbipTimePeriod.all
          expect(sdbip_time_periods).to be_truthy
          end

          it "assigns @users" do
          users = User.all
          expect(users).to be_truthy
          end

          it "assigns @departmental_sdbips" do
          departmental_sdbips = DepartmentalSdbip.all
          expect(departmental_sdbips).to be_truthy
          end
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("dashboard")}
    end

    context "when user is not logged in" do
          before do
              session[:user_id] = nil
              get :dashboard
          end
          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end
end
