require 'spec_helper'
require 'rails_helper'

RSpec.describe HeadingsController, :type => :controller do

  describe "#index" do
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
      context "when user is not logged in" do
            before do
                get :index
            end
            it {expect(response).to redirect_to(login_path)}
            it {flash[:danger].should eq("Please log in.")}
        end
    end

  describe "#edit_top_layer_headings" do
        context "when user is admin and logged in" do

          before do
            @user = create(:user)
            @heading = create(:heading)
            session[:user_id] = @user.id
            {:id=>@heading.id}
            get :edit_top_layer_headings,{:id=>@heading.id}

          end

          xit {expect(response.status).to eq(200) }
          xit {expect(response.content_type).to eq("text/js") }
          xit {expect(response).to render_template("/headings/:id/edit_top_layer_headings")}

          end
          context "when user is not logged in" do
                before do
                    get :edit_top_layer_headings, :id=>1
                end
                xit {expect(response).to redirect_to(login_path)}
                xit {flash[:danger].should eq("Please log in.")}
            end

        end

  describe "#edit_capital_projects_headings" do
        context "when user is admin and logged in" do

          before do
            @user = create(:user)
            @heading = create(:heading)
            session[:user_id] = @user.id
            get :edit_capital_projects_headings,{:id=>@heading.id}
          end
          xit {expect(response.status).to eq(200) }
          xit {expect(response.content_type).to eq("text/html") }
          xit {expect(response).to render_template("/headings/:id/edit_capital_projects_headings")}

          end
          context "when user is not logged in" do
                before do
                    get :edit_capital_projects_headings, :id=>1
                end
                xit {expect(response).to redirect_to(login_path)}
                xit {flash[:danger].should eq("Please log in.")}
            end

            context "when user is not admin" do
              before do
                  get :edit_capital_projects_headings, :id=>1
              end
              xit {expect(response).to redirect_to(login_path)}
            end
        end
  describe "#edit_revenue_by_source_headings" do
    context "when user is admin and logged in" do

      before do
        @user = create(:user)
        @heading = create(:heading)
        session[:user_id] = @user.id
        get :edit_revenue_by_source_headings,{:id=>@heading.id}
      end
      xit {expect(response.status).to eq(200) }
      xit {expect(response.content_type).to eq("text/html") }
      xit {expect(response).to render_template("/headings/:id/edit_revenue_by_source_headings")}

      end
      context "when user is not logged in" do
            before do
                get :edit_revenue_by_source_headings, :id=>1
            end
            xit {expect(response).to redirect_to(login_path)}
            xit {flash[:danger].should eq("Please log in.")}
        end

    end

    describe "#edit_departmental_headings" do
      context "when user is admin and logged in" do
        before do
          @user = create(:user)
          @heading = create(:heading)
          session[:user_id] = @user.id
          get :edit_departmental_headings,{:id=>@heading.id}
        end
        xit {expect(response.status).to eq(200) }
        xit {expect(response.content_type).to eq("text/html") }
        xit {expect(response).to render_template("/headings/:id/edit_departmental_headings")}

        end
        context "when user is not logged in" do
              before do
                  get :edit_departmental_headings,{:id=>@heading.id}
              end
              xit {expect(response).to redirect_to(login_path)}
              xit {flash[:danger].should eq("Please log in.")}
          end

          context "when user is not admin" do
            before do
                get :edit_departmental_headings, :id=>1
            end
            xit {expect(response).to redirect_to(login_path)}
          end
      end
  describe "#edit_monthly_cashflow_headings" do
    context "when user is admin and logged in" do

      before do
        @user = create(:user)
        @heading = create(:heading)
        session[:user_id] = @user.id
        get :edit_monthly_cashflow_headings,{:id=>@heading.id}
      end
      xit {expect(response.status).to eq(200) }
      xit {expect(response.content_type).to eq("text/html") }
      xit {expect(response).to render_template("/headings/:id/edit_monthly_cashflow_headings")}

      end
      context "when user is not logged in" do
            before do
                @heading = create(:heading)
                get :edit_monthly_cashflow_headings,{:id=>@heading.id}
            end
            xit {expect(response).to redirect_to(login_path)}
            xit {flash[:danger].should eq("Please log in.")}
        end

        context "when user is not admin" do
          before do
              get :edit_monthly_cashflow_headings, :id=>1
          end
          xit {expect(response).to redirect_to(login_path)}
        end
    end
    describe "#edit" do
      context "when user is admin and logged in" do

        before do
          @user = create(:user)
          @heading = create(:heading)
          session[:user_id] = @user.id
          get :edit,{:id=>@heading.id}
        end
        it {expect(response.status).to eq(200) }
        it {expect(response.content_type).to eq("text/html") }
        xit {expect(response).to render_template("/headings/:id/edit")}
        end
        context "when user is not logged in" do
              before do
                @heading = create(:heading)
                get :edit,{:id=>@heading.id}
              end
              it {expect(response).to redirect_to(login_path)}
              it {flash[:danger].should eq("Please log in.")}
          end


      end

    describe "#new" do
      context "when user is admin and logged in" do

        before do
          @user = create(:user)
          session[:user_id] = @user.id
          get :new
        end
        it {expect(response.status).to eq(200) }
        it {expect(response.content_type).to eq("text/html") }
        it {expect(response).to render_template("new")}
        end
        context "when user is not logged in" do
              before do
                  get :new
              end
              it {expect(response).to redirect_to(login_path)}
              it {flash[:danger].should eq("Please log in.")}
          end
      end

    describe "#destroy" do
      context "when user is admin and logged in" do

        before do
          @user = create(:user)
          session[:user_id] = @user.id
          @heading = create(:heading)
          get :destroy,:id=>@heading.id
        end

        xit {assigns(:heading).to eq(@heading)}
        xit {expect(response.status).to eq(200) }
        it {flash[:success].should eq("Heading was successfully deleted.")}
        it {expect(response).to redirect_to("/headings")}
        end
      end

    describe "#create" do
      context "when user is admin and logged in" do
        before do
          @user = create(:user)
          session[:user_id] = @user.id
          get :new
        end
        xit "redirects to the index page upon save" do
          expect{
             post :create, :heading => Factory.attributes_for(:heading)
           }
          #expect(Heading.count).to not_eq(0)
          expect(response.status).to eq(200)
          flash[:success].should eq("Heading was successfully created.")
          expect(response).to redirect_to("/headings")
        end
        end
        context "when user is not logged in" do
              before do
                  get :new
              end
              it {expect(response).to redirect_to(login_path)}
              it {flash[:danger].should eq("Please log in.")}
          end

      end
      describe "#update" do
        context "when user is admin and logged in" do

          before do
            @user = create(:user)
            session[:user_id] = @user.id
            @heading = create(:heading)

          end
          xit "" do
            put :update
          end
          it {expect(response.status).to eq(200) }
          xit {flash[:success].should eq("Heading was successfully updated.")}
          xit {expect(response).to redirect_to("/headings")}
          end
          context "when user is not logged in" do
                before do
                    get :edit, :id=>1
                end
                it {expect(response).to redirect_to(login_path)}
                it {flash[:danger].should eq("Please log in.")}
            end

            context "when user is not admin" do
              before do
                  get :edit, id: 1
              end
              it {expect(response).to redirect_to(login_path)}
            end
        end

    

    #def log_in(user)
    #  post login_path, :email=> user.email, :password=> user.password
    #end
end
