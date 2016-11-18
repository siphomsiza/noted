class SdbipTimePeriodsController < ApplicationController
   before_action :logged_in_user, only: [:close_primary,:close_secondary,:close_finance,:index, :show, :edit, :update, :destroy,:update_time_periods]
  before_action :admin_user, only: [:close_primary,:close_secondary,:close_finance,:index, :show, :edit, :update, :destroy,:update_time_periods]
  skip_before_filter  :verify_authenticity_token
  def index
    weather_details
    @sdbip_time_period = SdbipTimePeriod.new
    @sdbip_time_periods = SdbipTimePeriod.all.order(id: :asc)
  end

  def show
    @sdbip_time_period = SdbipTimePeriod.find(params[:id])
  end

  def new
    @sdbip_time_period = SdbipTimePeriod.new
  end

  def create
    @sdbip_time_period = SdbipTimePeriod.new(sdbip_time_period_params)
    if @sdbip_time_period.save
      SendTimePeriodReminderEmailJob.set(wait: 10.seconds).perform_later
      flash[:success]="Sdbip Time Period was successfully created."
      redirect_to sdbip_time_periods_path
    else
      flash[:danger]="Sdbip Time Period was not updated."
      redirect_to :back
    end
  end

  def edit
    @sdbip_time_period = SdbipTimePeriod.find(params[:id])
  end
  def send_notification
    #sends a reminder notification to Administrators
    @primary_reminders = SdbipTimePeriod.where("extract(month from primary_reminder) <= ? AND extract(year from primary_reminder) = ? AND primary_status = ? AND primary_notification_sent = ?",Date.today.month,Date.today.year,true,false)
    @secondary_reminders = SdbipTimePeriod.where("extract(month from secondary_reminder) <= ? AND extract(year from secondary_reminder) = ? AND secondary_status = ? AND secondary_notification_sent = ? ",Date.today.month,Date.today.year,true,false)
    if !@primary_reminders.blank?
      @primary_sdbip_time_periods = @primary_reminders
      @primary_users = User.includes(:role).where(roles:{kpi_owner: true})
    if !@primary_sdbip_time_periods.blank?
      @primary_users.each do |user|
        @user = User.find(user.id)
        @user.send_primary_reminder_email
      end
      @primary_sdbip_time_periods.each do |sdbip_time_period|
        sdbip_time_period.update_columns(:primary_notification_sent => true)
      end
    end
    end
  if !@secondary_reminders.blank?
    @secondary_users = User.joins(:roles).where("roles.finance_admin = ? OR roles.top_layer_administrator = ? OR roles.secondary_time_period = ?",true,true,true)#includes(:role).where(:roles => {"role.finance_admin = ? OR role.top_layer_administrator = ? OR role.secondary_time_period = ?",true,true,true})#(roles:{finance_admin: true,top_layer_administrator: true, secondary_time_period: true})
    @secondary_sdbip_time_periods = @secondary_reminders
    if !@secondary_sdbip_time_periods.blank?
      @secondary_users.each do |user|
        @user = User.find(user.id)
        @user.send_secondary_reminder_email
      end
      @secondary_sdbip_time_periods.each do |sdbip_time_period|
        sdbip_time_period.update_columns(:secondary_notification_sent => true)
      end
    end
  end
  redirect_to :back
  end
  def update_status
    #Auto close a time period
    @closed_primary = SdbipTimePeriod.where("extract(month from primary_closure) <= ? AND extract(year from primary_closure) = ? AND primary_status = ?",Date.today.month,Date.today.year,true)
    @closed_secondary = SdbipTimePeriod.where("extract(month from secondary_closure) <= ? AND extract(year from secondary_closure) = ? AND secondary_status = ?",Date.today.month,Date.today.year,true)
    if !@closed_primary.blank?
    @primary_sdbip_time_periods = @closed_primary
    @primary_sdbip_time_periods.each do |primary_sdbip_time_period|
      primary_sdbip_time_period.update_columns(:primary_status => false)
    end
    end
  if !@closed_secondary.blank?
    @secondary_sdbip_time_periods = @closed_secondary
    @secondary_sdbip_time_periods.each do |secondary_sdbip_time_period|
      secondary_sdbip_time_period.update_columns(:secondary_status => false)
    end
  end
  redirect_to :back
  end
  def close_primary
    @sdbip_time_period = SdbipTimePeriod.find(params[:id])
    if @sdbip_time_period.update_columns(:primary_status => false)
      flash[:success] = "Time periods closed successfully."
      redirect_to :back
    else
      flash[:danger] = "Failed to close time periods."
      redirect_to :back
    end
  end

  def close_secondary
    @sdbip_time_period = SdbipTimePeriod.find(params[:id])
    if @sdbip_time_period.update_columns(:secondary_status => false)
      flash[:success] = "Time periods closed successfully."
      redirect_to :back
    else
      flash[:danger] = "Failed to close time periods."
      redirect_to :back
    end
  end

  def close_finance
    @sdbip_time_period = SdbipTimePeriod.find(params[:id])
    if @sdbip_time_period.update_columns(:finance_status => false)
      flash[:success] = "Time periods closed successfully."
      redirect_to :back
    else
      flash[:danger] = "Failed to close time periods."
      redirect_to :back
    end
  end

  def update_time_periods
    if params[:primary_reminder] || params[:secondary_reminder] || params[:primary_closure] || params[:secondary_closure]
      @time_periods = SdbipTimePeriod.all
      @time_periods.each do |time_period|
        new_primary_reminder = time_period.period.days_ago(-params[:primary_reminder].to_i)
        new_primary_closure = time_period.period.days_ago(-params[:primary_closure].to_i)
        new_secondary_reminder = time_period.period.days_ago(-params[:secondary_reminder].to_i)
        new_secondary_closure = time_period.period.days_ago(-params[:secondary_closure].to_i)
        @time_period = SdbipTimePeriod.find(time_period.id)
        @time_period.update_columns(:primary_reminder => new_primary_reminder,:primary_closure=>new_primary_closure,:secondary_reminder=>new_secondary_reminder,:secondary_closure=>new_secondary_closure)
        @primary_users = User.includes(:role).where(roles:{kpi_owner: true})
        @secondary_users = User.includes(:role).where(roles:{finance_admin: true,top_layer_administrator: true,secondary_time_period: true})
        #TimePeriodReminder.send_primary_time_period_reminder_email(@primary_users).deliver
        #TimePeriodReminder.send_secondary_time_period_reminder_email(@secondary_users).deliver

        #reminder_date = (@sdbip_time_period.primary_reminder - Date.now)* 24 * 60
          SendTimePeriodReminderEmailJob.set(wait: 30.seconds).perform_later
      end
        flash[:success] = "All automatic time periods updated successfully."
        redirect_to :back
    else
      flash[:danger] = "All automatic time periods were not updated."
      redirect_to :back
    end
  end

  def import
    if params[:file].nil?
       flash[:danger] = 'You have not selected a file'
      redirect_to sdbip_time_periods_url
    else
    begin
       SdbipTimePeriod.delay(run_at: 30.seconds.from_now).import(params[:file])
       flash[:success] = "Time periods imported successfully."
       redirect_to sdbip_time_periods_url
    rescue => e
       Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
      flash[:danger] = "Time periods failed to import #{e.message}."
       redirect_to sdbip_time_periods_url
    end
    end
  end

  def update_deadline
    selected_month_value = params[:selected_month].strftime("%m")
    @sdbip_time_period = SdbipTimePeriod.where("extract (month from period) = ?", selected_month_value)
    if @sdbip_time_period.update_columns(primary_closure: params[:data_value])
      redirect_to :back
    else
      redirect_to :back
    end
  end
  def update
      @sdbip_time_period = SdbipTimePeriod.find(params[:id])
    if @sdbip_time_period.update_attributes(sdbip_time_period_params)
      @primary_users = User.includes(:role).where(roles:{kpi_owner: true})
      @secondary_users = User.includes(:role).where(roles:{finance_admin: true,top_layer_administrator: true,secondary_time_period: true})

      #reminder_date = (@sdbip_time_period.primary_reminder - Date.now)* 24 * 60
      SendTimePeriodReminderEmailJob.set(wait: 30.seconds).perform_later
      flash[:success]="Sdbip Time Period was successfully updated."
      redirect_to sdbip_time_periods_path
    else
      flash[:danger]="Sdbip Time Period was not updated."
      redirect_to :back
    end
  end

  def destroy
    @sdbip_time_period = SdbipTimePeriod.find(params[:id])
    @sdbip_time_period.destroy
        flash[:success]="Sdbip Time Period was successfully deleted."
        redirect_to sdbip_time_periods_path
  end




  private
    def sdbip_time_period_params
        params.require(:sdbip_time_period).permit(:period,:primary_reminder, :primary_closure,:secondary_reminder,:secondary_closure,:finance_reminder,:finance_closure,:finance_status,:primary_status,:secondary_status)
    end
      # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin? || current_user.super_admin?
  end
end
