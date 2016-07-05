class DepartmentalSdbipProgress < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :departmental_sdbip
	def self.generate_report(department_id)
		if department_id
  		 includes(:departmental_sdbip).where(:departmental_sdbips=>{department_id: department_id})
		else
		end
	end

end
