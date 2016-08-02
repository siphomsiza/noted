class TimePeriodReminder < ApplicationMailer

  default :from => 'noreply@sableassets.co.za'

  def send_time_period_reminder_email
    @primary_users = User.includes(:role).where(roles:{kpi_owner: true})
    @secondary_users = User.includes(:role).where(roles:{finance_admin: true,top_layer_administrator: true,secondary_time_period: true})

    @primary_users.each do |primary_user|
      mail to: primary_user.email, subject: "KPI Update Reminder"
    end
    #mail to: "Rachidi@sableassets.co.za", subject: "KPI Update Reminder"
  end

end
