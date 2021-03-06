require 'spec_helper'
require 'rails_helper'

RSpec.describe HeadingsController, :type => :controller do

  let!(:first_heading)  { Heading.create(:term => "Capital Name", :description => "Capital Name", :category => "Capital Project")}

  describe "#index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end

          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end

    context "when user is not logged in" do
          before do
              session[:user_id] = nil
              get :index
          end
          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit_top_layer_headings" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              @heading = create(:heading)
              session[:user_id] = @user.id
              get :edit_top_layer_headings,:id=>@heading.id , :format => 'js'
          end

          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template(:edit_top_layer_headings)}
    end

    context "when user is not logged in" do

          before do
              @heading = create(:heading)
              session[:user_id] = nil
              get :edit_top_layer_headings,:id=>@heading.id, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit_capital_projects_headings" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              @heading = create(:heading)
              session[:user_id] = @user.id
              get :edit_capital_projects_headings,:id=>@heading.id, :format => 'js'
          end

          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template(:edit_capital_projects_headings)}
    end

    context "when user is not logged in" do

          before do
              @heading = create(:heading)
              session[:user_id] = nil
              get :edit_capital_projects_headings,{:id=>@heading.id}, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit_revenue_by_source_headings" do
    context "when user is admin and logged in" do

        before do
          @user = create(:user)
          @heading = create(:heading)
          session[:user_id] = @user.id
          get :edit_revenue_by_source_headings,:id=>@heading.id, :format => 'js'
        end
        it {expect(response).to have_http_status(200)}
        it {expect(response.content_type).to eq("text/javascript") }
        it {expect(response).to render_template(:edit_revenue_by_source_headings)}
        end

        context "when user is not logged in" do
              before do
                @heading = create(:heading)
                session[:user_id] = nil
                get :edit_revenue_by_source_headings,:id=>@heading.id, :format => 'js'
              end
              it {expect(response).to redirect_to(login_path)}
              it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit_departmental_headings" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              @heading = create(:heading)
              session[:user_id] = @user.id
              get :edit,:id=>@heading.id, :format => 'js'
          end

          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template(:edit)}
    end

    context "when user is not logged in" do

          before do
              @heading = create(:heading)
              session[:user_id] = nil
              get :edit,:id=>@heading.id, :format => 'js'
              end
              it {expect(response).to redirect_to(login_path)}
              it {expect(flash[:danger]).to eq("Please log in.")}
          end

  end

  describe "#edit_monthly_cashflow_headings" do
    context "when user is admin and logged in" do

        before do
          @user = create(:user)
          @heading = create(:heading)
          session[:user_id] = @user.id
          get :edit_monthly_cashflow_headings,:id=>@heading.id, :format => 'js'
        end
         it {expect(response).to have_http_status(200)}
        it {expect(response.content_type).to eq("text/javascript") }
        it {expect(response).to render_template(:edit_monthly_cashflow_headings)}
        end
        context "when user is not logged in" do
              before do
                @heading = create(:heading)
                session[:user_id] = nil
                get :edit_monthly_cashflow_headings,:id=>@heading.id, :format => 'js'
              end
              it {expect(response).to redirect_to(login_path)}
              it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit" do
    context "when user is admin and logged in" do

         before do
             @user = create(:user)
             @heading = create(:heading)
             session[:user_id] = @user.id
             get :edit,:id=>@heading.id, :format => 'js'
          end

          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template(:edit)}
          end

    context "when user is not logged in" do

          before do
              @heading = create(:heading)
              session[:user_id] = nil
              get :edit,:id=>@heading.id, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end
  describe "#edit_departmental_headings" do
    context "when user is admin and logged in" do

         before do
             @user = create(:user)
             @heading = create(:heading)
             session[:user_id] = @user.id
             get :edit_departmental_headings,:id=>@heading.id, :format => 'js'
          end

          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template(:edit_departmental_headings)}
          end

    context "when user is not logged in" do

          before do
              @heading = create(:heading)
              session[:user_id] = nil
              get :edit_departmental_headings,:id=>@heading.id, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end
  describe "DELETE #destroy" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @heading = create(:heading)
              delete :destroy,:id=>@heading.id
          end

          it {expect(assigns(:heading)).to eq(@heading)}
          it {expect(flash[:success]).to eq("Heading was successfully deleted.")}
          it {expect(response).to redirect_to headings_path}
    end
  end

  describe "#create" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              heading = Heading.create
              get :index
          end

          it "#save revenue_by_source" do

          heading_params = FactoryGirl.attributes_for(:heading)
          expect {(assigns[:heading]).to eq(Heading(heading_params)) }
          expect { post :create, :heading => heading_params }.to change(Heading, :count).by(1)
          end
          it { expect(response).to have_http_status(200)}
    end

    context "when user is not logged in" do

          before do
          session[:user_id] = nil
          get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#update" do
          before do
              request.env['HTTP_REFERER'] = root_url
              @heading = FactoryGirl.create(:heading)
              @user = FactoryGirl.create(:user)
              session[:user_id] = @user.id
              get :edit, :id => @heading.id, :format => 'js'
          end
          it "should redirect to index with a notice on successful update" do
          @attr = { :term => "kpi name", :description => "kpi name", :category => "Departmental SDBIP"}
          patch :update, :id => @heading.id, :heading => @attr
          expect(assigns[:heading]).not_to be_new_record
          expect(flash[:success]).to eq("Heading was successfully updated.")
          expect(response).to redirect_to  :back
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :term => nil, "description" => "kpi name", "category" => "Top Layer SDBIP"}
          patch :update, :id => @heading.id, :heading => @attr
          expect(assigns[:heading]).not_to be_new_record
          expect(flash[:danger]).to eq("Heading was not updated.")
          expect(response).to redirect_to :back
          end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :edit, :id=>1, :format => 'js'
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end
end
