class DepartmentalSdbipProgress < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :departmental_sdbip
	def self.generate_report(department_id)
		if department_id
  		 includes(:departmental_sdbip).where(:departmental_sdbips=>{department_id: department_id})
		else
		end
	end
  def self.report_to_csv(data_value,selected_array_of_values,options = {})
    CSV.generate(options) do |csv|
  		column_names = [selected_columns]
  		csv << column_names
  		all.each do
  			csv << [selected_array_of_values]
  		end
  	end

  end
end
