class SdbipTimePeriodsController < ApplicationController
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

  def import
    if params[:file].nil?
       flash[:danger] = 'You have not selected a file'
      redirect_to sdbip_time_periods_url
    else
    begin
       SdbipTimePeriod.delay(run_at: 30.seconds.from_now).import(params[:file])
       flash[:success] = "Time periods imported successfully."
       redirect_to sdbip_time_periods_url
    rescue
      flash[:danger] = "Time periods failed to import."
       redirect_to sdbip_time_periods_url
    end
  end
  end

  def update
        @sdbip_time_period = SdbipTimePeriod.find(params[:id])

    if @sdbip_time_period.update_attributes(sdbip_time_period_params)
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
        params.require(:sdbip_time_period).permit(:sdbip_id, :period, :start_date, :end_date)
    end
end
