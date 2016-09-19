class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end
  def account_unlocked(user)
    @user = user
    mail to: user.email, subject: "Account Unlocked"
  end
  def account_locked(user)
    @user = user
    mail to: user.email, subject: "Account Locked"
  end
  def primary_reminder_email(user)
    @user = user
    mail to: user.email, subject: "KPI Update Reminder"
  end
  def secondary_reminder_email(user)
    @user = user
    mail to: user.email, subject: "KPI Update Reminder"
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

end
