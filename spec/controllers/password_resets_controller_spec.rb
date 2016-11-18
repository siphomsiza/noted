
require 'spec_helper'
require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do

        describe "#create" do
        context "when user is admin and logged in" do
        before do
          @user = create(:user)
          session[:user_id] = @user.id
        end
        it "#create user" do
          expect { post :create, { :email=> @user.email, :password=>"ghgh576fg55654" } }
          user_params = FactoryGirl.attributes_for(:user)
          expect {(assigns[:user]).to eq(User(user_params)) }
          expect { post :create, :user => user_params }.to change(User, :count).by(1) 
     
          end
     
         it { expect(response).to have_http_status(200)}
       
          end
        end

        describe "PATCH update" do
          context "with no token found" do
               it "renders the edit page" do
                    patch :update, id: 'notfound',user: {password: 'newpassword1', password_confirmation: 'newpassword1'}
                    expect(response).to render_template('edit')
               end

               it "sets the flash message" do
                    patch :update, id: 'notfound',user: {password: 'newpassword1', password_confirmation: 'newpassword1'}
                    expect(flash[:notice]).to match(/not found/)
               end
          end

          context "with a valid token" do
               let(:user) {create(:user)}
               before {user.generate_password_reset_token!}

               it "updates the user's password" do
                    digest = user.password_digest

                    patch :update, id: user.password_reset_token, user: {password:'newpassword1', password_confirmation: 'newpassword1'}
                              user.reload
                    expect(user.password_digest).to_not eq(digest)
               end

               it "clears the password_reset_token" do
                    patch :update, id: user.password_reset_token, user: {password:'newpassword1', password_confirmation: 'newpassword1'}
                              user.reload
                    expect(user.password_reset_token).to be_blank
               end

               it "sets the session[:user_id] to the user's id" do
                    patch :update, id: user.password_reset_token, user: {password:'newpassword1', password_confirmation: 'newpassword1'}
                         expect(session[:user_id]).to eq(user.id)

               end

               it "sets the flash[:success] message" do
                    patch :update, id: user.password_reset_token, user: {password:'newpassword1', password_confirmation: 'newpassword1'}
                         expect(flash[:success]).to match(/Password Updated./)

               end

               it "redirects to the todo_lists page" do
                    patch :update, id: user.password_reset_token, user: {password:'newpassword1', password_confirmation: 'newpassword1'}
                         expect(response).to redirect_to(todo_lists_path)

               end
          end

     end

         describe "#get_user" do
          context "when user is logged in" do
            before do
            @user = create(:user)
            end
          
            it "should successfully get a user" do
            expect { post :create, { :email=> @user.email, :password=>@user.password } }
            expect { password_reset[:user_id] = @user.id }
        
            end
            it { expect(response).to have_http_status(200)}
            end
           end
end
