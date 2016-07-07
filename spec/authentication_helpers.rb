module AuthenticationHelpers
  module Controller
    def log_in(user)
      controller.stub(:current_user).and_return(user)
      controller.stub(:user_id).and_return(user.id)
    end
  end

  module Feature
    def log_in(user,options={})
      visit '/login'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button "Log in"
    end
  end

end
