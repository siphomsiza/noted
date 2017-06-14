require 'active_record/fixtures'

file = Rails.root.to_s + "/db_engcobo/data/engcobo_upload_template_1_June_SDBIP_1617/engcobo_mti_upload_template_1_june_sdbip_1617.xlsx"
xlsx = Roo::Spreadsheet.open(file)
xlsx.default_sheet = xlsx.sheets.first
starting_row_number = xlsx.first_row
ending_row_number = xlsx.last_row
header_row_number = starting_row_number
header_row = xlsx.row( header_row_number)

counts = 0
(header_row_number + 1).upto(ending_row_number) do |row_number|
  row_data = xlsx.row(row_number)
  department = ::Department.find_by_name(row_data[header_row.index('Department')].titleize)
  strategic_objective = StrategicObjective.find_by_name(row_data[header_row.index('Strategic  Objective')])
  counts +=1 if strategic_objective.present?
end
binding.pry
