class SdbipTimePeriodsController < ApplicationController
   before_action :logged_in_user, only: [:close_primary,:close_secondary,:close_finance,:index, :show, :edit, :update, :destroy,:update_time_periods]
  before_action :admin_user, only: [:close_primary,:close_secondary,:close_finance,:index, :show, :edit, :update, :destroy,:update_time_periods]
  def index
    begin

        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
      #@response = @client.fetch_by_location('New York')
      #@response.units.temperature
      #@response.condition.temp

  rescue SignalException => e
    flash[:notice] = "received Exception #{e.message}"
    puts "received Exception #{e}"
  end
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
