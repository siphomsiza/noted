class CapitalProject < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :departmental_sdbip
  belongs_to :subdepartment
  belongs_to :mscore_classification
  belongs_to :area
  belongs_to :ward
  has_one :monthly_cashflow
  validates :subdepartment, :mscore_classification, :project_name,:departmental_sdbip_id, :presence => true

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
 def self.report_to_csv(options = {})
 	selected_columns = $selected_array_of_headers
 	column_names = selected_columns
 	array_of_values = $selected_array_of_values
 	CSV.generate(options) do |csv|
 		csv << column_names
 		all.each do |capital_project|

       #if !MscoreClassification.exists?(:departmental_sdbip_id=>departmental_sdbip.id)
 				#array_of_values.each do |s|
     			#s.gsub!('departmental_sdbip.capital_project.mun_cp_ref', '')
 				#end
 				#csv << array_of_values.map{|n|eval n}

 			#elsif CapitalProject.exists?(:departmental_sdbip_id=>departmental_sdbip.id)
 				csv << array_of_values.map{|n|eval n}
       #end

 		end
 	end

 end
 def self.generate_report(selected_project_columns,department_id,subdepartment_id,
   idp_number,vote_number,
   project_name,project_description,
   mscore_classification_id,planned_start_date,
   planned_completion_date,funding_source,
   ward_id,
   area_id,mun_cp_ref,actual_start_date,
   actual_completion_date)

   @audits = CapitalProject#.includes(:activities)
   audit_columns = []
   audit_columns_headers = []

   if selected_project_columns.include?("Department")
     audit_columns.push("capital_project.departmental_sdbip.department_name")
     audit_columns_headers.push("Department")

   end

   if selected_project_columns.include?("Sub-Department")
     audit_columns.push("capital_project.subdepartment.subdepartment_name")
     audit_columns_headers.push("Sub-Department")
     if !subdepartment_id.blank?
       subdepartments_value = subdepartment_id
       @audits = @audits.where(:subdepartment_id => subdepartments_value.split(""))
     end
   end

   if selected_project_columns.include?("GFS Classification")
     audit_columns.push("capital_project.departmental_sdbip.mscore_classification.name")
     audit_columns_headers.push("GFS Classification")
     if !mscore_classification_id.blank?
       mscore_classification_value = mscore_classification_id
       @audits = @audits.where(:mscore_classification_id => mscore_classification_value.split(""))
     end
   end

   if selected_project_columns.include?("Mun CP Ref")
     audit_columns.push("capital_project.mun_cp_ref")
     audit_columns_headers.push("Mun CP Ref")
     if !mun_cp_ref.blank?
       mun_cp_ref_value = mun_cp_ref
       @audits = @audits.where(:mun_cp_ref => mun_cp_ref_value.split(""))
     end
   end

   if selected_project_columns.include?("IDP Number")
     audit_columns.push("capital_project.idp_nummber")
     audit_columns_headers.push("IDP Number")
     if !idp_number.blank?
       idp_number_value = idp_number
       @audits = @audits.where(:idp_nummber => idp_number_value.split(""))
     end
   end

   if selected_project_columns.include?("Vote Number")
     audit_columns.push("capital_project.mun_cp_ref")
     audit_columns_headers.push("Vote Number")
     if !vote_number.blank?
       vote_number_ref_value = vote_number
       @audits = @audits.where(:vote_nummber => vote_number_ref_value.split(""))
     end
   end

   if selected_project_columns.include?("Funding Source")
     audit_columns.push("capital_project.funding_source")
     audit_columns_headers.push("Funding Source")
     if !funding_source.blank?
       funding_source_value = funding_source
       @audits = @audits.where(:funding_source => funding_source_value.split(""))
     end
   end

   if selected_project_columns.include?("Project Description")
     audit_columns.push("capital_project.departmental_sdbip.kpi_ref_number")
     audit_columns_headers.push("Project Description")
     if !project_description.blank?
       kpi_owner_values = project_description
       @audits = @audits.where(:kpi_owner_id => kpi_owner_values.split(""))
     end
   end

   if selected_project_columns.include?("Project Name")
     audit_columns.push("capital_project.project_name")
     audit_columns_headers.push("Project Name")
     if !project_name.blank?
       kpi_ref_number_values = project_name
       @audits = @audits.where(:id => kpi_ref_number_values.split(""))

     end
   end

   if selected_project_columns.include?("Area")
     #audit_columns.push("capital_project.area.name")
     audit_columns_headers.push("Area")
     if !area_id.blank?
       area_values = area_id
       @audits = @audits.where(:area_id => area_values.split(""))

     end
   end
   if selected_project_columns.include?("Ward")
     #audit_columns.push("capital_project.ward.name")
     audit_columns_headers.push("Ward")
     if !ward_id.blank?
       ward_values = ward_id
       @audits = @audits.where(:ward_id => ward_values.split(""))

     end

   end
   if selected_project_columns.include?("Planned Start Date")
     audit_columns.push("capital_project.planned_start_date")
     audit_columns_headers.push("Planned Start Date")

   end
   if selected_project_columns.include?("Planned Completion Date")
     audit_columns.push("capital_project.planned_completion_date")
     audit_columns_headers.push("Planned Completion Date")

   end
   if selected_project_columns.include?("Actual Start Date")
     audit_columns.push("capital_project.actual_start_date")
     audit_columns_headers.push("Actual Start Date")
   end
   if selected_project_columns.include?("Actual Completion Date")
     audit_columns.push("capital_project.actual_completion_date")
     audit_columns_headers.push("Actual Completion Date")

   end
  $selected_array_of_values = audit_columns
  $selected_array_of_headers = audit_columns_headers
  @audit_logs = @audits
end

end
