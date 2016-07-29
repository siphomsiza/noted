class TimePeriodReminder < ApplicationMailer

  default :from => 'noreply@sableassets.co.za'

  def send_primary_time_period_reminder_email(users)
    #users.each do |user|mail to: user.email, subject: "KPI Update Reminder" end
    mail to: "Rachidi@sableassets.co.za", subject: "KPI Update Reminder"
  end
  def send_secondary_time_period_reminder_email(users)
    #users.each do |user|mail to: user.email, subject: "KPI Update Reminder" end
    mail to: "Rachidi@sableassets.co.za", subject: "KPI Update Reminder"
  end

end
