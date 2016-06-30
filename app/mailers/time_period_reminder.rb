class TimePeriodReminder < ApplicationMailer

  default :from => 'noreply@sableassets.co.za'

  def send_time_period_reminder_email
    #user.email = "Rachidi@sableassets.co.za"
    mail to: "Rachidi@sableassets.co.za", subject: "KPI Update Reminder"
  end

end
