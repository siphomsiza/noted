class CapitalProject < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :department
  belongs_to :departmental_sdbip
  belongs_to :subdepartment
  belongs_to :mscore_classification
  belongs_to :area
  belongs_to :ward

  validates :department_id , :subdepartment, :mscore_classification, :project_description, :presence => true

  def self.import(file)
  	case File.extname(file.original_filename)
   	when ".csv" then
     CSV.foreach(file.path, headers: true) do |row|
       capital_project_hash = row.to_hash
       capital_project = CapitalProject.where(id: capital_project_hash["id"])

       if capital_project.count == 1
         capital_project.first.update_attributes(capital_project_hash)
       else
         CapitalProject.create!(capital_project_hash)
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
     capital_project_hash = row.to_hash#.slice(*accessible_attributes)
     capital_project = where(id: row["id"])
     if capital_project.count == 1
         capital_project.first.update_attributes(capital_project_hash)
       else
         CapitalProject.create!(capital_project_hash)
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
