class TopLayerSdbip < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  include PublicActivity::Common
  belongs_to :department
  belongs_to :mscore_classification
  belongs_to :national_outcome
  belongs_to :kpi_target_type
  belongs_to :kpa
  belongs_to :predetermined_objective
  belongs_to :strategic_objective
  belongs_to :ndp_objective
  belongs_to :ward
  belongs_to :area
  belongs_to :kpi_owner
  belongs_to :mtas_indicator
  belongs_to :kpi_calculation_type
  belongs_to :kpi_target_type

  validates :department_id, :mtas_indicator_id, :mscore_classification_id, :national_outcome_id,:ndp_objective_id,
  :predetermined_objective_id, :strategic_objective_id,:kpa_id, :ward_id,:area_id, :kpi_owner_id, :kpi_calculation_type_id, :kpi_target_type_id, :presence => true
  def self.import(file)
  	case File.extname(file.original_filename)
   	when ".csv" then
     CSV.foreach(file.path, headers: true) do |row|
       top_layer_sdbip_hash = row.to_hash
       top_layer_sdbip = TopLayerSdbip.where(id: top_layer_sdbip_hash["id"])

       if top_layer_sdbip.count == 1
         top_layer_sdbip.first.update_attributes(top_layer_sdbip_hash)
       else
         TopLayerSdbip.create!(top_layer_sdbip_hash)
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
     top_layer_sdbip_hash = row.to_hash#.slice(*accessible_attributes)
     top_layer_sdbip = where(id: row["id"])
     if top_layer_sdbip.count == 1
         top_layer_sdbip.first.update_attributes(top_layer_sdbip_hash)
       else
         TopLayerSdbip.create!(top_layer_sdbip_hash)
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
