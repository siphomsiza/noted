class SdbipTimePeriodsController < ApplicationController
   before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy,:update_time_periods]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy,:update_time_periods]
  def index
    @sdbip_time_period = SdbipTimePeriod.new
    @sdbip_time_periods = SdbipTimePeriod.paginate( page: params[:page],per_page: 50)
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
  def update_time_periods
    if params[:primary_reminder] || params[:secondary_reminder] || params[:primary_closure] || params[:secondary_closure]
      @time_periods = SdbipTimePeriod.all
      if @time_periods.update_all(:primary_reminder => params[:primary_reminder],:primary_closure=>params[:primary_closure],:secondary_reminder=>params[:secondary_reminder],:secondary_closure=>params[:secondary_closure])
        flash[:success] = "All automatic time periods updated successfully."
        redirect_to :back
      end
    else
      flash[:warning] = "All automatic time periods were not updated."
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

  def update
      @sdbip_time_period = SdbipTimePeriod.find(params[:id])
    if @sdbip_time_period.update_attributes(sdbip_time_period_params)
      reminder_date = (@sdbip_time_period.primary_reminder - Date.now)* 24 * 60
      SendTimePeriodReminderEmailJob.set(wait: reminder_date.minutes).perform_later
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
        params.require(:sdbip_time_period).permit(:period, :primary_reminder, :primary_closure,:secondary_reminder,:secondary_closure,:finance_reminder,:finance_closure,:finance_status,:primary_status,:secondary_status)
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
    redirect_to(root_url) unless current_user.admin?
  end
end
