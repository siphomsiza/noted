require 'roo'
require 'active_record'

module EngcoboDataLoad
  class << self
    def load_mti_file
      file = Rails.root.to_s + "/db/data/engcobo_upload_template_1_June_SDBIP_1617/engcobo_mti_upload_template_1_june_sdbip_1617.xlsx"
      xlsx = Roo::Spreadsheet.open(file)
      xlsx.default_sheet = xlsx.sheets.first
      starting_row_number = xlsx.first_row
      ending_row_number = xlsx.last_row
      header_row_number = starting_row_number
      header_row = xlsx.row( header_row_number)

      (header_row_number + 1).upto(ending_row_number) do |row_number|
        row_data = xlsx.row(row_number)
        db_conf = YAML.load(File.open(File.join(Rails.root, '/config', 'database.yml')))
        ActiveRecord::Base.establish_connection(db_conf['db4'][Rails.env])
        department = ::Department.find_by_name(row_data[header_row.index('Department')])
        binding.pry
      end
    end
  end
end
