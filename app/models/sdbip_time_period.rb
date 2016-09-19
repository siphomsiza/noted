class SdbipTimePeriod < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  include PublicActivity::Common
  has_many :departmental_sdbips
  belongs_to :sdbip_report
  def self.import(file)
  	case File.extname(file.original_filename)
   	when ".csv" then
     CSV.foreach(file.path, headers: true) do |row|
       sdbip_time_period_hash = row.to_hash
       sdbip_time_period = SdbipTimePeriod.where(id: sdbip_time_period_hash["id"])

       if sdbip_time_period.count == 1
         sdbip_time_period.first.update_attributes(sdbip_time_period_hash)
       else
         SdbipTimePeriod.create!(sdbip_time_period_hash)
       end # end if !departmental_sdbip.nil?

     end # end CSV.foreach

 	when ".xls" then
 		fetch_excel_data(file)

   	when ".xlsx" then
   	 	fetch_excel_data(file)

   	when ".ods" then
   	 	fetch_excel_data(file)

   	else raise "Unknown file type: #{file.original_filename}"
   	end

   end

 def self.fetch_excel_data(file)

   spreadsheet = open_spreadsheet(file)
   header = spreadsheet.row(1)
   (2..spreadsheet.last_row).each do |i|
     row = Hash[[header, spreadsheet.row(i)].transpose]
     sdbip_time_period_hash = row.to_hash#.slice(*accessible_attributes)
     sdbip_time_period = where(id: row["id"])
     if sdbip_time_period.count == 1
         sdbip_time_period.first.update_attributes(sdbip_time_period_hash)
       else
         SdbipTimePeriod.create!(sdbip_time_period_hash)
       end
   end
 end
 
 def self.open_spreadsheet(file)

   case File.extname(file.original_filename)

   when ".xls" then
   	Roo::Spreadsheet.open(file.path)


   when ".xlsx" then
   	Roo::Spreadsheet.open(file.path)

   when ".ods" then
   	Roo::Spreadsheet.open(file.path)

   else raise "Unknown file type: #{file.original_filename}"
   end
 end
end
