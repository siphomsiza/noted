class SdbipReportsController < ApplicationController
  def new
  	@sdbip_report = SdbipReport.new
  end

  def edit
  	@sdbip_report = SdbipReport.find([:id])
  end

  def index
  	@sdbip_report = SdbipReport.new
  	@sdbip_reports = SdbipReport.all
  	respond_to do | format | 
  format.html # index.html.erb
  format.json { render :json => @posts }
   format.csv { send_data @sdbip_reports.to_csv }
  format.xlsx {
    xlsx_package = SdbipReport.to_xlsx
    begin
      temp = Tempfile.new("sdbip_report.xlsx")
      xlsx_package.serialize temp.path
      send_file temp.path, :filename => "posts.xlsx", :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ensure
      temp.close
      temp.unlink
    end
 }  
  end
  end

  def show
  	@sdbip_report = SdbipReport.find([:id])
  end

  def export

  end


  def create
  	@sdbip_report = SdbipReport.new(report_params)
  	if @sdbip_report.save
  		redirect_to sdbip_reports_path , :success=> "Progress saved successfully!"
  	else
  		redirect_to new_sdbip_report_path, :danger=>"Progress not saved!"
  	end
  end

  def update
  	@sdbip_report = SdbipReport.find([:id])
  end

  private
  def report_params
  	params.require(:sdbip_report).permit(:sdbip_time_period_id,:percentage_actual,:financial_actual,:performance_comments,:corrective_measure,:proof_of_evidence,:past_year_performance,:performance_standard)
  end
end
