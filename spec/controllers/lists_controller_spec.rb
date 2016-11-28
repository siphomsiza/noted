require 'spec_helper'
require 'rails_helper'

RSpec.describe ListsController, :type => :controller do

  describe "#index" do
    context "when user is admin and logged in" do
          before do
              @user = User.find_by(email: "casey@sableassets.com")
              session[:user_id] = @user.id
              get :index
          end
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
        end
    context "when user is not logged in" do
          before do
              session[:user_id] = nil
              get :index
          end
          it {expect(response.status).to eq(302) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to(login_url)}
        end
    end
end
