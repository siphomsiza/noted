module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.firstname, class: "gravatar")
  end
  def options_for_title
  	options_for_select(["Dr.", "Miss.", "Mr.", "Mrs.", "Ms.", "Prof.", "Rev."])
  end
  def options_for_race
  	 options_for_select(["African", "Coloured", "Indian", "White"])
  end
  def options_for_occupational_category
  	options_for_select(["Top Management", "Senior Manager, Professionally Qualified, Experienced and Specialist", "Middle Management", "Skilled Technician and Academically Qualified Worker",
            "Junior Management, Supervisor, Foreman and Superintendent","Semi-skilled and Discretionary Decision Making","Unskilled and Defined Decision Making"])
  end
  def system_administration_user(user)
    (current_user.admin? || current_user.super_admin?) && !current_user?(user) && (!user.admin? || !user.super_admin?)
  end
  def user_account_locked(user)
    user.login_attempts < user.max_login_attempts
  end
end
