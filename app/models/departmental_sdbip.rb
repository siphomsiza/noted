class DepartmentalSdbip < ActiveRecord::Base
	belongs_to :department
	belongs_to :list
	belongs_to :subdepartment
	belongs_to :kpi_owner
	belongs_to :predetermined_objective
	belongs_to :mscore_classification
	belongs_to :national_outcome
	belongs_to :strategic_objective
	belongs_to :kpa
	belongs_to :area
	belongs_to :funding_source
	belongs_to :kpi_calculation_type
	belongs_to :kpi_concept
	belongs_to :kpi_target_type
	belongs_to :kpi_type
	belongs_to :mtas_indicator
	belongs_to :ndp_objective
	belongs_to :provincial_strategic_outcome
	belongs_to :reporting_category
	belongs_to :revenue_by_source
	belongs_to :risk_rating
	belongs_to :strategic_objective
	belongs_to :ward
	belongs_to :departmental_idp_objective
	belongs_to :capital_project
	belongs_to :sdbip_time_period
	belongs_to :sdbip_report
	has_many :departmental_sdbip_progresses, :dependent => :destroy
	accepts_nested_attributes_for :departmental_sdbip_progresses,allow_destroy: true

  #validate :extension_white_list

	def subdepartment_for_form
    	collection = departmental_sdbip_progresses.where(departmental_sdbip_id: id)
    	collection.any? ? collection : departmental_sdbip_progresses.build
  	end

 def self.import(file)
 	case File.extname(file.original_filename)
  	when ".csv" then
    CSV.foreach(file.path, headers: true) do |row|
      departmental_sdbip_hash = row.to_hash
      departmental_sdbip = DepartmentalSdbip.where(id: departmental_sdbip_hash["id"])

      if departmental_sdbip.count == 1
        departmental_sdbip.first.update_attributes(departmental_sdbip_hash)
      else
        DepartmentalSdbip.create!(departmental_sdbip_hash)
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
    departmental_sdbip_hash = row.to_hash#.slice(*accessible_attributes)
    departmental_sdbip = where(id: row["id"])
    if departmental_sdbip.count == 1
        departmental_sdbip.first.update_attributes(departmental_sdbip_hash)
      else
        DepartmentalSdbip.create!(departmental_sdbip_hash)
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


def self.filter_report(data_value,departments_value,subdepartments_value,kpi_owner_values,predetermined_objectives_values,ward_values,kpi_concept_values,kpi_type_values,kpi_calculation_type_values,area_values,kpi_values,kpa_values,provincial_strategic_outcome_values,mscore_classification_values,ndp_objective_values,strategic_objective_values,national_outcome_values)

		@sdbip_progresses = DepartmentalSdbip.all

		if data_value.include?('Department')

			@sdbip_progresses = @sdbip_progresses.where(:department_id => departments_value.split(""))

		end
		if data_value.include?('Sub-Department')

			@sdbip_progresses = @sdbip_progresses.where(:subdepartment_id => subdepartments_value.split(""))

		end
		if data_value.include?('KPI Owner')
			@sdbip_progresses = @sdbip_progresses.where(:kpi_owner_id => kpi_owner_values.split(""))
		end
		#if data_value.include?('Project Name')
		#	@sdbip_progresses = @sdbip_progresses.where(["id = ?",project_name])
		#end
		#if data_value.include?('KPI Ref Number')
		#	@sdbip_progresses = @sdbip_progresses.where(["kpi_ref_number = ?",kpi_ref_number])
		#end
		#if data_value.include?('Revised Target')
		#	@sdbip_progresses = @sdbip_progresses.where(["revised_target = ?",revised_target])
		#end
		if data_value.include?('KPI Concept')
			@sdbip_progresses = @sdbip_progresses.where(:kpi_concept_id => kpi_concept_values.split(""))
		end
		if data_value.include?('KPI Type')
			@sdbip_progresses = @sdbip_progresses.where(:kpi_type_id => kpi_type_values.split(""))
		end
#
		if data_value.include?('KPI Calculation Type')
			@sdbip_progresses = @sdbip_progresses.where(:kpi_calculation_type_id => kpi_calculation_type_values.split(""))
		end

		#if data_value.include?('Top Layer KPI Ref')
		#	@sdbip_progresses = @sdbip_progresses.where(["top_layer_kpi_ref = ?",top_layer_kpi_ref])
		#end
		#if data_value.include?('Baseline')
		#	@sdbip_progresses = @sdbip_progresses.where(["baseline = ?",baseline])
		#end
		if data_value.include?('Wards')
			@sdbip_progresses = @sdbip_progresses.where(:ward_id => ward_values.split(""))
		end
		if data_value.include?('Area')
			@sdbip_progresses = @sdbip_progresses.where(:area_id => area_values.split(""))
		end
#
		#if data_value.include?('Budget')
		#	@sdbip_progresses = @sdbip_progresses.where(["budget = ?",budget])
		#end
		if data_value.include?('KPI')
			@sdbip_progresses = @sdbip_progresses.where(:kpi => kpi_values.split(""))
		end
		if data_value.include?('KPA')
			@sdbip_progresses = @sdbip_progresses.where(:kpa_id => kpa_values.split(""))
		end
		#if data_value.include?('Past Year Performance')
		#	@sdbip_progresses = @sdbip_progresses.where(["past_year_performance = ?",past_year_performance])
		#end
		if data_value.include?('Provincial Strategic Outcome')
			@sdbip_progresses = @sdbip_progresses.where(:provincial_strategic_outcome_id => provincial_strategic_outcome_values.split(""))
		end
		if data_value.include?('Predetermined Objectives')
			@sdbip_progresses = @sdbip_progresses.where(:predetermined_objective_id => predetermined_objectives_values.split(""))
		end
		#if data_value.include?('Reporting Category')
		#	@sdbip_progresses = @sdbip_progresses.where(["reporting_category_id = ?",reporting_category_id])
		#end
		if data_value.include?('GFS Classification')
			@sdbip_progresses = @sdbip_progresses.where(:mscore_classification_id => mscore_classification_values.split(""))
		end
#
		if data_value.include?('NDP Objectives')
			@sdbip_progresses = @sdbip_progresses.where(:ndp_objective_id => ndp_objective_values.split(""))
		end
		#if data_value.include?('IDP Ref')
		#	@sdbip_progresses = @sdbip_progresses.where(["idp_ref = ?",idp_ref])
		#end
		if data_value.include?('Strategic Objective')
			@sdbip_progresses = @sdbip_progresses.where(:strategic_objective_id => strategic_objective_values.split(""))
		end
		#if data_value.include?('Impact')
		#	@sdbip_progresses = @sdbip_progresses.where(["impact = ?",impact])
		#end
		#if data_value.include?('Source of Evidence')
		#	@sdbip_progresses = @sdbip_progresses.where(["source_of_evidence = ?",source_of_evidence])
		#end
		#if data_value.include?('Unit of Measurement')
		#	@sdbip_progresses = @sdbip_progresses.where(["unit_of_measurement = ?",unit_of_measurement])
		#end
		if data_value.include?('National Outcome')
			@sdbip_progresses = @sdbip_progresses.where(:national_outcome_id => national_outcome_values.split(""))
		end
		#if !annual_target.blank?  && annual_target.to_i > 0
		#	@sdbip_progresses = @sdbip_progresses.where(["annual_target = ?",annual_target])
		#end
		@departmental_sdbip_progresses = @sdbip_progresses

end


def self.report_to_csv(data_value,options = {})
CSV.generate(options) do |csv|
	column_names = [data_value]
	csv << column_names
	all.each do |departmental_sdbip|
		#csv << [departmental_sdbip.kpi_ref_number, departmental_sdbip.kpi,departmental_sdbip.department.name, departmental_sdbip.subdepartment.subdepartment_name,departmental_sdbip.kpa.name,departmental_sdbip.kpi_type.name,departmental_sdbip.kpi_owner.name,departmental_sdbip.strategic_objective.name,departmental_sdbip.baseline,departmental_sdbip.annual_target,departmental_sdbip.revised_target,departmental_sdbip.first_quarter_target,departmental_sdbip.second_quarter_target,departmental_sdbip.third_quarter_target,departmental_sdbip.fourth_quarter_target, departmental_sdbip.area.name,departmental_sdbip.ward.name,departmental_sdbip.source_of_evidence,departmental_sdbip.unit_of_measurement]
	end
end
end
	def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    column_names = ["KPI Ref no.","KPI","Department","Subdepartment","KPA","KPI Type","KPI Owner","Strategic Objectives","Baseline","Annual Target","Revised Target","1st Quarter Target","2nd Quarter Target","3rd Quarter Target","4th Quarter Target","Area","Ward","Source of Evidence","Unit of Measurement"]
    csv << column_names
    all.each do |departmental_sdbip|
      csv << [departmental_sdbip.kpi_ref_number, departmental_sdbip.kpi,departmental_sdbip.department.name, departmental_sdbip.subdepartment.subdepartment_name,departmental_sdbip.kpa.name,departmental_sdbip.kpi_type.name,departmental_sdbip.kpi_owner.name,departmental_sdbip.strategic_objective.name,departmental_sdbip.baseline,departmental_sdbip.annual_target,departmental_sdbip.revised_target,departmental_sdbip.first_quarter_target,departmental_sdbip.second_quarter_target,departmental_sdbip.third_quarter_target,departmental_sdbip.fourth_quarter_target, departmental_sdbip.area.name,departmental_sdbip.ward.name,departmental_sdbip.source_of_evidence,departmental_sdbip.unit_of_measurement]
    end
  end
	end

	def self.search(subdepartment_id,kpi_type_id,start_date,end_date)
		@sdbips = DepartmentalSdbip.all
		if !subdepartment_id.blank?
  			@sdbips = @sdbips.where(["subdepartment_id = ?",subdepartment_id])
		end
		if !kpi_type_id.blank?
			if kpi_type_id == "0"
				@sdbips = @sdbips
			end
			if kpi_type_id.to_i > 0
				@sdbips = @sdbips.where(["kpi_type_id = ?",kpi_type_id])
			end
		end
		if !start_date.blank? && start_date.length > 1
			@sdbips=@sdbips.where(["start_date >= ?",start_date])
		end
		if !end_date.blank? && end_date.length > 1
			@sdbips=@sdbips.where(["end_date <= ?",end_date])

		end
		@departmental_sdbips = @sdbips
	end

	def self.search_kpi(kpi_id,department_id,subdepartment_id,kpi_type_id,start_date,end_date)

		if department_id && subdepartment_id && kpi_type_id && start_date && end_date
  			where(["kpi_owner_id = ? AND department_id = ? AND subdepartment_id = ? AND kpi_type_id = ? AND start_date >= ? AND end_date <= ?",kpi_id, department_id, subdepartment_id, kpi_type_id, start_date, end_date])
		else
		end

	end

	def self.search_departmental_kpis(department_id,subdepartment_id,kpi_type_id,start_date,end_date)

		if department_id && subdepartment_id && kpi_type_id && start_date && end_date
  			where(["department_id = ? AND subdepartment_id = ? AND kpi_type_id = ? AND start_date >= ? AND end_date <= ?",department_id, subdepartment_id, kpi_type_id, start_date, end_date])
		else
		end

	end

	def self.search_subdepartment_kpis(department_id,subdepartment_id,kpi_type_id,start_date,end_date)
			if department_id && subdepartment_id && kpi_type_id && start_date && end_date
				where(["department_id = ? AND subdepartment_id = ? AND kpi_type_id = ? AND start_date >= ? AND end_date <= ?",department_id, subdepartment_id, kpi_type_id, start_date, end_date])
		else
		end
	end

  def extension_white_list
    %w(xls xlsx ods csv)
  end

private

#Costom Report


end
