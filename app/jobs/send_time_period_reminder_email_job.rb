class SendTimePeriodReminderEmailJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    #TimePeriodReminder.send_time_period_reminder_email.deliver
    #To send emails at specific date time, we are going to use deliver_later with the wait_until option
    TimePeriodReminder.send_time_period_reminder_email.deliver_later(wait_until: 60.seconds.from_now)
  end
end
