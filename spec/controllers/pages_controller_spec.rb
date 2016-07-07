require 'spec_helper'
require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "#introduction" do
    context "when user is logged in" do

          before do
              user = create(:user)
              #log_in(user)
              get :introduction
          end
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("introduction")}
      end
      context "when user is not logged in" do
            before do
                get :introduction
            end
            xit {expect(response).to redirect_to(login_path)}
            xit {expect(flash[:danger]).to eq("Please log in.")}
        end

    end
    describe "#about" do
      context "when user is logged in" do

            before do
                user = create(:user)
                #log_in(user)
                get :about
            end
            it {expect(response.status).to eq(200) }
            it {expect(response.content_type).to eq("text/html") }
            it {expect(response).to render_template("about")}
        end
        context "when user is not logged in" do
              before do
                  get :introduction
              end
              xit {expect(response).to redirect_to(login_path)}
              xit {expect(flash[:danger]).to eq("Please log in.")}
          end
      end



    #def log_in(user)
    #  post login_path, :email=> user.email, :password=> user.password
    #end
end
