class DepartmentalSdbip < ActiveRecord::Base
  include PublicActivity::Model
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  belongs_to :department
  belongs_to :subdepartment
  belongs_to :kpi_owner
  belongs_to :predetermined_objective
  belongs_to :mscore_classification
  belongs_to :national_outcome
  belongs_to :strategic_objective
  belongs_to :kpa
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
  has_one :capital_project
  has_many :kpi_results, dependent: :destroy
  accepts_nested_attributes_for :kpi_results, allow_destroy: true
  has_many :assurances, dependent: :destroy
  accepts_nested_attributes_for :assurances, allow_destroy: true
  validates :department_name, :subdepartment_name, :kpi, :kpi_ref_number,:performance_standard, presence: true
  delegate :kpi, :id, :unit_of_measurement, :kpi, :kpi_ref_number, :annual_target, :source_of_evidence, to: :capital_project, prefix: true
  delegate :source_of_evidence, to: :kpi_results, prefix: true

  # validate :extension_white_list
  def self.chart_theme(departments_sdibps)
    $colors = []
    departments_sdibps.each do |color|
      $colors.push('orange') if color.performance_standard.include?('KPI Almost Met')
      $colors.push('darkblue') if color.performance_standard.include?('KPI Extremely Well Met')
      $colors.push('limegreen') if color.performance_standard.include?('KPI Met')
      $colors.push('red') if color.performance_standard.include?('KPI Not Met')
      $colors.push('#F4C2C2') if color.performance_standard.include?('KPI Not Yet Measured')
      $colors.push('darkgreen') if color.performance_standard.include?('KPI Well Met')
    end
    $colors = $colors
  end
  # def self.import_from_file(file)
  #     DepartmentalSdbip.import(file)
  # end
  #
  #  class << self
  #     def import(file)
  #       file = Dir.glob(File.join("#{Rails.root}/db_mkhondo/data/SDBIPs",'*.*')).max {|a,b| File.ctime(a) <=> File.ctime(b)}
  #       my_file = File.basename(file)
  #       case File.extname(my_file)
  #         when '.csv' then
  #             CSV.foreach(file, headers: true) do |row|
  #                 departmental_sdbip_hash = row.to_hash
  #                 departmental_sdbip = DepartmentalSdbip.find_or_create_by(id: departmental_sdbip_hash['id'])
  #                 departmental_sdbip.save!
  #             end # end CSV.foreach
  #
  #         when '.xls' then
  #             fetch_excel_data(file)
  #
  #         when '.xlsx' then
  #             fetch_excel_data(file)
  #
  #         when '.ods' then
  #             fetch_excel_data(file)
  #
  #         else raise "Unknown file type: #{file}"
  #
  #       end
  #     end
  #     handle_asynchronously :import_from_file, priority: 2, run_at: proc { 3.seconds.from_now }, queue: 'departmental_sdbips'
  #     # reload_page
  #  end
  # def self.fetch_excel_data(file)
  #     spreadsheet = open_spreadsheet(file)
  #     header = spreadsheet.row(1)
  #     (2..spreadsheet.last_row).each do |i|
  #         row = Hash[[header, spreadsheet.row(i)].transpose]
  #         departmental_sdbip_hash = row.to_hash # .slice(*accessible_attributes)
  #         departmental_sdbip = where(id: row['id'])
  #         if departmental_sdbip.count == 1
  #             departmental_sdbip.first.update_attributes(departmental_sdbip_hash)
  #         else
  #             DepartmentalSdbip.create!(departmental_sdbip_hash)
  #         end
  #     end
  #     #handle_asynchronously :import_from_file, priority: 2, run_at: proc { 3.seconds.from_now }, queue: 'departmental_sdbips'
  # end
  #
  # def self.open_spreadsheet(file)
  #     my_file = File.basename(file)
  #     case File.extname(file)
  #
  #     when '.xls' then
  #         Roo::Spreadsheet.open(my_file)
  #
  #     when '.xlsx' then
  #         Roo::Spreadsheet.open(my_file)
  #
  #     when '.ods' then
  #         Roo::Spreadsheet.open(my_file)
  #
  #     else raise "Unknown file type: #{file}"
  #     end
  # end
  def self.copy_sdbip_to_system(file)
    if $logged_in_database == DB1_CONF
      Dir.mkdir("#{Rails.root}/db_mkhondo/data/SDBIPs") unless Dir.exist?("#{Rails.root}/db_mkhondo/data/SDBIPs")
      temp_file = file.tempfile
      FileUtils.copy(temp_file, "#{Rails.root}/db_mkhondo/data/SDBIPs")
      # DepartmentalSdbip.import_from_file(File.open(File.join(Rails.root,'/db_mkhondo/data/SDBIPs',File.basename(temp_file))))
    elsif $logged_in_database == DB2_CONF
      Dir.mkdir("#{Rails.root}/db_sakhisizwe/data/SDBIPs") unless Dir.exist?("#{Rails.root}/db_sakhisizwe/data/SDBIPs")
      temp_file = file.tempfile
      FileUtils.copy(temp_file, "#{Rails.root}/db_sakhisizwe/data/SDBIPs")
      # DepartmentalSdbip.import_from_file(File.open(File.join(Rails.root,'/db_mkhondo/data/SDBIPs',File.basename(temp_file))))
    elsif $logged_in_database == DB3_CONF
      Dir.mkdir("#{Rails.root}/db_lepelle_nkumpi/data/SDBIPs") unless Dir.exist?("#{Rails.root}/db_lepelle_nkumpi/data/SDBIPs")
      temp_file = file.tempfile
      FileUtils.copy(temp_file, "#{Rails.root}/db_lepelle_nkumpi/data/SDBIPs")
      # DepartmentalSdbip.import_from_file(File.open(File.join(Rails.root,'/db_mkhondo/data/SDBIPs',File.basename(temp_file))))
    else
      Dir.mkdir("#{Rails.root}/db/data/SDBIPs") unless Dir.exist?("#{Rails.root}/db/data/SDBIPs")
      temp_file = file.tempfile
      FileUtils.copy(temp_file, "#{Rails.root}/db/data/SDBIPs")
      # DepartmentalSdbip.import_from_file(File.open(File.join(Rails.root,'/db_mkhondo/data/SDBIPs',File.basename(temp_file))))
    end
  end
  def self.import(file)
    case File.extname(file.original_filename)
    when '.csv' then
      CSV.foreach(file.path, headers: true) do |row|
        departmental_sdbip_hash = row.to_hash
        departmental_sdbip = DepartmentalSdbip.where(id: departmental_sdbip_hash['id'])

        if departmental_sdbip.count == 1
          departmental_sdbip.first.update_attributes(departmental_sdbip_hash)
        else
          DepartmentalSdbip.create!(departmental_sdbip_hash)
        end # end if !departmental_sdbip.nil?
      end # end CSV.foreach

    when '.xls' then
      fetch_excel_data(file)

    when '.xlsx' then
      fetch_excel_data(file)

    when '.ods' then
      fetch_excel_data(file)

    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.fetch_excel_data(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      departmental_sdbip_hash = row.to_hash # .slice(*accessible_attributes)
      departmental_sdbip = where(id: row['id'])
      if departmental_sdbip.count == 1
        departmental_sdbip.first.update_attributes(departmental_sdbip_hash)
      else
        DepartmentalSdbip.create!(departmental_sdbip_hash)
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)

    when '.xls' then
      Roo::Spreadsheet.open(file.path)

    when '.xlsx' then
      Roo::Spreadsheet.open(file.path)

    when '.ods' then
      Roo::Spreadsheet.open(file.path)

    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.filter_sdbip_report(sdbip_top_layer_kpi_ref_filters, sdbip_capital_project_filters, selected_columns, department_id, subdepartment_id,
                               kpi_ref_number, predetermined_objective_id,
                               kpi_owner_id, kpi,
                               unit_of_measurement,
                               mscore_classification_id, strategic_objective_id,
                               source_of_evidence, baseline,
                               annual_target, revised_target,
                               national_kpa_id, ndp_objective_id,
                               kpi_concept_id, kpi_type_id,
                               provincial_strategic_outcome_id, ward_id,
                               area_id, performance_standard, past_year_performance,
                               impact,
                               kpi_calculation_type_id, _kpi_target_type_id, start_date, end_date)

    @audits = DepartmentalSdbip.all
    audit_columns = []
    audit_columns_headers = []
    $period_headers = []

    unless sdbip_top_layer_kpi_ref_filters.blank?

      if sdbip_top_layer_kpi_ref_filters == 'all kpis'

      elsif sdbip_top_layer_kpi_ref_filters == 'not linked to top layer kpi'
        @audits = @audits.where(top_layer_kpi_ref: '')
      elsif sdbip_top_layer_kpi_ref_filters == 'linked to top layer kpi'
        @audits = @audits.where.not(top_layer_kpi_ref: '')
      end
    end

    unless sdbip_capital_project_filters.blank?

      if sdbip_capital_project_filters == 'all kpis'

      elsif sdbip_capital_project_filters == 'operational kpis only'
        @audits = @audits.where(capital_project_id: '')
      elsif sdbip_capital_project_filters == 'kpis associated with capital projects only'
        @audits = @audits.where.not(capital_project_id: '')
      end

    end
    audit_columns.push('departmental_sdbip.id')
    audit_columns_headers.push('Ref')
    $period_headers.push('')
    if selected_columns.include?('Department')
      audit_columns.push('departmental_sdbip.department_name')
      audit_columns_headers.push('Department')
      $period_headers.push('')
      if !department_id.blank? && department_id != '0'
        departments_value = department_id
        @audits = @audits.where(department_id: [departments_value.split('')])
      else
        @audits = @audits
      end
    end

    if selected_columns.include?('Sub-Department')
      audit_columns.push('departmental_sdbip.subdepartment_name')
      audit_columns_headers.push('Sub-Department')
      $period_headers.push('')
      unless subdepartment_id.blank?
        subdepartments_value = subdepartment_id
        @audits = @audits.where(subdepartment_id: [subdepartments_value.split('')])
      end
    end

    if selected_columns.include?('KPI Owner')
      audit_columns.push('departmental_sdbip.kpi_owner.name')
      audit_columns_headers.push('KPI Owner')
      $period_headers.push('')
      unless kpi_owner_id.blank?
        kpi_owner_values = kpi_owner_id
        @audits = @audits.where(kpi_owner_id: kpi_owner_values.split(''))

      end
    end

    if selected_columns.include?('KPI Ref Number')
      audit_columns.push('departmental_sdbip.kpi_ref_number')
      audit_columns_headers.push('KPI Ref Number')
      $period_headers.push('')
      unless kpi_ref_number.blank?
        kpi_ref_number_values = kpi_ref_number
        @audits = @audits.where(kpi_ref_number: kpi_ref_number_values.split(''))

      end
    end
    if selected_columns.include?('KPI Concept')
      audit_columns.push('departmental_sdbip.kpi_concept.name')
      audit_columns_headers.push('KPI Concept')
      $period_headers.push('')
      unless kpi_concept_id.blank?
        kpi_concept_values = kpi_concept_id
        @audits = @audits.where(kpi_concept_id: kpi_concept_values.split(''))

      end
    end
    if selected_columns.include?('KPI Type')
      audit_columns.push('departmental_sdbip.kpi_type.name')
      audit_columns_headers.push('KPI Type')
      $period_headers.push('')
      unless kpi_type_id.blank?
        kpi_type_values = kpi_type_id
        @audits = @audits.where(kpi_type_id: kpi_type_values.split(''))

      end
    end
    if selected_columns.include?('KPI Calculation Type')
      audit_columns.push('departmental_sdbip.kpi_calculation_type.name')
      audit_columns_headers.push('KPI Calculation Type')
      $period_headers.push('')
      unless kpi_calculation_type_id.blank?
        kpi_calculation_type_values = kpi_calculation_type_id
        @audits = @audits.where(kpi_calculation_type_id: kpi_calculation_type_values.split(''))
      end
    end

    if selected_columns.include?('Top Layer KPI Ref')
      audit_columns.push('departmental_sdbip.top_layer_kpi_ref')
      audit_columns_headers.push('Top Layer KPI Ref')
      $period_headers.push('')
    end
    if selected_columns.include?('Baseline')
      audit_columns.push('departmental_sdbip.baseline')
      audit_columns_headers.push('Baseline')
      $period_headers.push('')
      unless baseline.blank?
        baseline_values = baseline
        @audits = @audits.where(baseline: baseline_values.split(''))

      end
    end
    if selected_columns.include?('Ward')
      audit_columns.push('departmental_sdbip.wards')
      audit_columns_headers.push('Ward')
      $period_headers.push('')
      unless ward_id.blank?
        ward_values = ward_id
        @audits = @audits.where(ward_id: ward_values.split(''))

      end

    end
    if selected_columns.include?('Area')
      audit_columns.push('departmental_sdbip.areas')
      audit_columns_headers.push('Area')
      $period_headers.push('')
      unless area_id.blank?
        area_values = area_id
        @audits = @audits.where(area_id: area_values.split(''))

      end
    end

    if selected_columns.include?('Capital Project')
      audit_columns.push('departmental_sdbip.capital_project.mun_cp_ref')
      audit_columns_headers.push('Capital Project')
      $period_headers.push('')
    end
    if 'KPI'.in?selected_columns
      audit_columns.push('departmental_sdbip.kpi')
      audit_columns_headers.push('KPI')
      $period_headers.push('')
      unless kpi.blank?
        kpi_values = kpi
        @audits = @audits.where(id: kpi_values.split(''))

      end
    end
    if selected_columns.include?('KPA')
      audit_columns.push('departmental_sdbip.kpa.name')
      audit_columns_headers.push('KPA')
      $period_headers.push('')
      unless national_kpa_id.blank?
        kpa_values = kpa_values
        @audits = @audits.where(kpa_id: kpa_values.split(''))

      end
    end
    if selected_columns.include?('Previous Year Actual Performance')
      audit_columns.push('departmental_sdbip.past_year_performance')
      audit_columns_headers.push('Previous Year Actual Performance')
      $period_headers.push('')
      unless past_year_performance.blank?
        past_year_performance_values = past_year_performance_values
        @audits = @audits.where(id: past_year_performance_values.split(''))

      end
    end
    if selected_columns.include?('Provincial Strategic Objectives')
      audit_columns.push('departmental_sdbip.provincial_strategic_outcome.name')
      audit_columns_headers.push('Provincial Strategic Objectives')
      $period_headers.push('')
      unless provincial_strategic_outcome_id.blank?
        provincial_strategic_outcome_values = provincial_startegic_id
        @audits = @audits.where(provincial_strategic_outcome_id: provincial_strategic_outcome_values.split(''))

      end
    end
    if selected_columns.include?('Pre-determined Objectives')
      audit_columns.push('departmental_sdbip.predetermined_objective.name')
      audit_columns_headers.push('Pre-determined Objectives')
      $period_headers.push('')

      unless predetermined_objective_id.blank?
        predetermined_objectives_values = predetermined_objective_id
        @audits = @audits.where(predetermined_objective_id: predetermined_objectives_values.split(''))
      end
    end
    if selected_columns.include?('GFS Classification')
      audit_columns.push('departmental_sdbip.mscore_classification.name')
      audit_columns_headers.push('GFS Classification')
      $period_headers.push('')
      unless mscore_classification_id.blank?
        mscore_classification_values = mscore_classification_id
        @audits = @audits.where(mscore_classification_id: mscore_classification_values.split(''))
      end
    end

    if selected_columns.include?('NDP Objectives')
      audit_columns.push('departmental_sdbip.ndp_objective.name')
      audit_columns_headers.push('NDP Objectives')
      $period_headers.push('')
      unless ndp_objective_id.blank?
        ndp_objective_values = ndp_objective_id
        @audits = @audits.where(ndp_objective_id: ndp_objective_values.split(''))

      end
    end

    if selected_columns.include?('Strategic Objectives')
      audit_columns.push('departmental_sdbip.strategic_objective.name')
      audit_columns_headers.push('Strategic Objectives')
      $period_headers.push('')
      unless strategic_objective_id.blank?
        strategic_objective_values = strategic_objective_id
        @audits = @audits.where(strategic_objective_id: strategic_objective_values.split(''))
      end
    end

    if selected_columns.include?('Impact')
      audit_columns.push('departmental_sdbip.impact')
      audit_columns_headers.push('Impact')
      $period_headers.push('')
      unless impact.blank?
        impact_values = impact_values
        @audits = @audits.where(impact: impact_values.split(''))

      end
    end
    if selected_columns.include?('Source of Evidence')
      audit_columns.push('departmental_sdbip.source_of_evidence')
      audit_columns_headers.push('Source of Evidence')
      $period_headers.push('')
      unless source_of_evidence.blank?
        source_of_evidence_values = source_of_evidence
        @audits = @audits.where(source_of_evidence: source_of_evidence_values.split(''))

      end
    end
    if selected_columns.include?('Unit of Measurement')
      audit_columns.push('departmental_sdbip.unit_of_measurement')
      audit_columns_headers.push('Unit of Measurement')
      $period_headers.push('')
      unless unit_of_measurement.blank?
        unit_of_measurement_values = unit_of_measurement_values
        @audits = @audits.where(unit_of_measurement: unit_of_measurement_values.split(''))
      end

    end
    if selected_columns.include?('National Outcome')
      audit_columns.push('departmental_sdbip.national_outcome.name')
      audit_columns_headers.push('National Outcome')
      $period_headers.push('')
    end
    if selected_columns.include?('Annual Target')
      audit_columns.push('departmental_sdbip.annual_target')
      audit_columns_headers.push('Annual Target')
      $period_headers.push('')
      unless annual_target.blank?
        annual_target_values = annual_target
        @audits = @audits.where(annual_target: annual_target_values.split(''))

      end
    end
    if selected_columns.include?('Revised Target')
      audit_columns.push('departmental_sdbip.revised_target')
      audit_columns_headers.push('Revised Target')
      $period_headers.push('')
      unless revised_target.blank?
        revised_target_values = revised_target
        @audits = @audits.where(revised_target: revised_target_values.split(''))

      end
    end
    if selected_columns.include?('Reporting Category')
      audit_columns.push('departmental_sdbip.reporting_category.name')
      audit_columns_headers.push('Reporting Category')
      $period_headers.push('')
    end
    if selected_columns.include?('IDP Ref')
      audit_columns.push('departmental_sdbip.idp_ref')
      audit_columns_headers.push('IDP Ref')
      $period_headers.push('')
    end
    if selected_columns.include?('Performance Standard')
      audit_columns.push('departmental_sdbip.performance_standard')
      audit_columns_headers.push('Performance Standard')
      $period_headers.push('')
      unless performance_standard.blank?
        @audits = @audits.where(performance_standard: performance_standard)
      end
    end
    if selected_columns.include?('Performance Comment')
      audit_columns.push('departmental_sdbip.performance_comments')
      audit_columns_headers.push('Performance Comment')
      $period_headers.push('')
    end
    if selected_columns.include?('Corrective Measures')
      audit_columns.push('departmental_sdbip.corrective_measures')
      audit_columns_headers.push('Corrective Measures')
      $period_headers.push('')
    end
    if selected_columns.include?('Proof of evidence')
      audit_columns.push('departmental_sdbip.first_quarter_poe')
      audit_columns_headers.push('Proof of evidence')
      $period_headers.push('')
    end
    if selected_columns.include?('KPI Target Type')
      audit_columns.push('departmental_sdbip.kpi_calculation_type.name')
      audit_columns_headers.push('KPI Target Type')
      $period_headers.push('')
    end
    if selected_columns.include?('KPI Target Type')
      audit_columns.push('kpi_result.kpi_calculation_type.name')
      audit_columns_headers.push('KPI Target Type')
      $period_headers.push('')
    end
    if selected_columns.include?('Target, Actual and Results')
      @kpi_results = KpiResult.all
      if !start_date.blank? && !end_date.blank?
          if (start_date.to_date.month >= 7) && (end_date.to_date.month == 9 || end_date.to_date.month == 12 || end_date.to_date.month == 3 || end_date.to_date.month == 6)
            audit_columns_headers.push("Target")
            audit_columns_headers.push("Actual")
            audit_columns_headers.push("Result")
            audit_columns.push('departmental_sdbip.first_quarter_target')
            audit_columns.push('departmental_sdbip.first_quarter_actual')
            audit_columns.push('departmental_sdbip.first_quarter_results')
            $period_headers.push("#{end_date}")
          end
          if (start_date.to_date.month >= 7) && (end_date.to_date.month == 12 || end_date.to_date.month == 3 || end_date.to_date.month == 6)
            audit_columns_headers.push("Target")
            audit_columns_headers.push("Actual")
            audit_columns_headers.push("Result")
            audit_columns.push('departmental_sdbip.second_quarter_target')
            audit_columns.push('departmental_sdbip.second_quarter_actual')
            audit_columns.push('departmental_sdbip.second_quarter_results')
            $period_headers.push("#{end_date}")
          end
          if (start_date.to_date.month >= 7 || start_date.to_date.month == 1 ) && (end_date.to_date.month == 3 || end_date.to_date.month == 6)
            audit_columns_headers.push("Target")
            audit_columns_headers.push("Actual")
            audit_columns_headers.push("Result")
            audit_columns.push('departmental_sdbip.third_quarter_target')
            audit_columns.push('departmental_sdbip.third_quarter_actual')
            audit_columns.push('departmental_sdbip.third_quarter_results')
            $period_headers.push("#{end_date}")
          end
          if (start_date.to_date.month >= 7 || start_date.to_date.month == 1 || start_date.to_date.month == 4) && (end_date.to_date.month == 6)# || (start_date.to_date.month >= 7 && end_date.to_date.month >= end_date.to_date.end_of_quarter.month)
            audit_columns_headers.push("Target")
            audit_columns_headers.push("Actual")
            audit_columns_headers.push("Result")
            audit_columns.push('departmental_sdbip.fourth_quarter_target')
            audit_columns.push('departmental_sdbip.fourth_quarter_actual')
            audit_columns.push('departmental_sdbip.fourth_quarter_results')
            $period_headers.push("#{end_date}")
          end
      end
    end
    $period_headers = $period_headers
    $results = @kpi_results
    $selected_array_of_values = audit_columns
    $selected_array_of_headers = audit_columns_headers
    @audit_logs = @audits
  end

  def self.report_to_csv(options = {})
    selected_columns = $selected_array_of_headers
    column_names = selected_columns
    array_of_values = $selected_array_of_values
    unless $results.blank?
      $results.each do |_kpi_result|
        column_names.push('Target')
        column_names.push('Actual')
        column_names.push('Results')
      end
    end
    CSV.generate(options) do |csv|
      unless $results.blank?
        first_headers = []
        !$results.select(:period).uniq.each do |header|
          first_headers.push(header.period.strftime('%b-%Y'))
        end
        csv << first_headers
      end
      csv << column_names
      all.each do |departmental_sdbip|
        if departmental_sdbip.kpi_owner_id.blank?
          array_of_values.each do |s|
            s.gsub!('departmental_sdbip.kpi_owner.name', '')
          end
          end
        if departmental_sdbip.predetermined_objective_id.blank?
          array_of_values.each do |s|
            s.gsub!('departmental_sdbip.predetermined_objective.name', '')
          end
        end
        if departmental_sdbip.mscore_classification_id.blank?
          array_of_values.each do |s|
            s.gsub!('departmental_sdbip.mscore_classification.name', '')
          end
        end
        if departmental_sdbip.strategic_objective_id.blank?
          array_of_values.each do |s|
            s.gsub!('departmental_sdbip.strategic_objective.name', '')
          end
        end
        if departmental_sdbip.ndp_objective_id.blank?
          array_of_values.each do |s|
            s.gsub!('departmental_sdbip.ndp_objective.name', '')
          end
        end
        if departmental_sdbip.kpi_owner_id.blank?
          array_of_values.each do |s|
            s.gsub!('departmental_sdbip.kpi_owner.name', '')
          end
        end
        if $selected_array_of_headers.include?('Target, Actual and Results')
          if departmental_sdbip.kpi_results.any?
            departmental_sdbip.kpi_results.each do |kpi_result|
              # array_of_values.push('departmental_sdbip.kpi_result');
            end
          elsif !departmental_sdbip.kpi_results.any?
            departmental_sdbip.kpi_results.each do |_kpi_result|
              array_of_values.push('')
            end
          end
        end
        if departmental_sdbip.kpi_results.any? && !$results.blank?
          $results.each do |_kpi_result|
            # array_of_values.push("departmental_sdbip.kpi_result.target")
            # column_names.push("departmental_sdbip.kpi_result.actual")
            # column_names.push("departmental_sdbip.kpi_result.kpi_performance_standard")
          end
        end
        if !CapitalProject.exists?(departmental_sdbip_id: departmental_sdbip.id)
          array_of_values.each do |s|
            s.gsub!('departmental_sdbip.capital_project.mun_cp_ref', '')
          end
          csv << array_of_values.map { |n| eval n }
        elsif CapitalProject.exists?(departmental_sdbip_id: departmental_sdbip.id)
          csv << array_of_values.map { |n| eval n }
        end
      end
    end
  end
  def self.selected_departments(department_id)
    @report_departments = Department.find(department_id) if department_id != '0'
    @report_departments = Department.all if department_id == '0'
    return @report_departments
  end
  def self.selected_kpi_results(start_date,end_date)
    @report_kpi_results = KpiResult.where('extract(month from created_at) >= ? AND extract(year from created_at) >= ? AND extract(month from created_at) <= ? AND extract(year from created_at) <= ?', start_date.to_date.month, start_date.to_date.year, end_date.to_date.month, end_date.to_date.year)
    return @report_kpi_results
  end
  def self.filter_audit_logs(top_layer_kpi_ref_filters, capital_project_filters, selected_columns, department_id, subdepartment_id,
                             kpi_ref_number, predetermined_objective_id,
                             kpi_owner_id, kpi,
                             unit_of_measurement,
                             mscore_classification_id, strategic_objective_id,
                             source_of_evidence, baseline,
                             annual_target, revised_target,
                             national_kpa_id, ndp_objective_id,
                             kpi_concept_id, kpi_type_id,
                             provincial_strategic_outcome_id, ward_id,
                             area_id, performance_standard, past_year_performance,
                             impact,
                             kpi_calculation_type_id, _kpi_target_type_id, start_date, end_date)

    @audits = DepartmentalSdbip.includes(:kpi_results, :assurances)
    audit_columns = []
    audit_columns_headers = []

    unless top_layer_kpi_ref_filters.blank?

      if top_layer_kpi_ref_filters == 'all kpis'

      elsif top_layer_kpi_ref_filters == 'not linked to top layer kpi'
        @audits = @audits.where(top_layer_kpi_ref: nil)
      elsif top_layer_kpi_ref_filters == 'linked to top layer kpi'
        @audits = @audits.where.not(top_layer_kpi_ref: nil)
      end
    end

    unless capital_project_filters.blank?

      if capital_project_filters == 'all kpis'

      elsif capital_project_filters == 'operational kpis only'
        @audits = @audits.where(departmental_sdbip: { kpi_type_id: 2 })
      elsif capital_project_filters == 'kpis associated with capital projects only'
        @audits = @audits.includes(:capital_projects)
      end

    end

    if selected_columns.include?('Department')
      audit_columns.push('departmental_sdbip.department_name')
      audit_columns_headers.push('Department')
      unless department_id.blank?
        departments_value = department_id
        @audits = @audits.where(department_id: departments_value.split(''))
      end
    end

    if selected_columns.include?('Sub-Department')
      audit_columns.push('departmental_sdbip.name')
      audit_columns_headers.push('Sub-Department')
      unless subdepartment_id.blank?
        subdepartments_value = subdepartment_id
        @audits = @audits.where(subdepartment_id: subdepartments_value.split(''))
      end
    end

    if selected_columns.include?('KPI Owner')
      audit_columns.push('departmental_sdbip.kpi_owner.name')
      audit_columns_headers.push('KPI Owner')
      unless kpi_owner_id.blank?
        kpi_owner_values = kpi_owner_id
        @audits = @audits.where(kpi_owner_id: kpi_owner_values.split(''))

      end
    end

    if selected_columns.include?('KPI Ref Number')
      audit_columns.push('departmental_sdbip.kpi_ref_number')
      audit_columns_headers.push('KPI Ref Number')
      unless kpi_ref_number.blank?
        kpi_ref_number_values = kpi_ref_number
        @audits = @audits.where(kpi_ref_number: kpi_ref_number_values.split(''))

      end
    end
    if selected_columns.include?('Revised Target')
      audit_columns.push('departmental_sdbip.revised_target')
      audit_columns_headers.push('Revised Target')
      unless revised_target.blank?
        revised_target_values = revised_target
        @audits = @audits.where(revised_target: revised_target_values.split(''))

      end
    end
    if selected_columns.include?('KPI Concept')
      audit_columns.push('departmental_sdbip.kpi_concept.name')
      audit_columns_headers.push('KPI Concept')
      unless kpi_concept_id.blank?
        kpi_concept_values = kpi_concept_id
        @audits = @audits.where(kpi_concept_id: kpi_concept_values.split(''))

      end
    end
    if selected_columns.include?('KPI Type')
      audit_columns.push('departmental_sdbip.kpi_type.name')
      audit_columns_headers.push('KPI Type')
      unless kpi_type_id.blank?
        kpi_type_values = kpi_type_id
        @audits = @audits.where(kpi_type_id: kpi_type_values.split(''))

      end
    end
    if selected_columns.include?('KPI Calculation Type')
      audit_columns.push('departmental_sdbip.kpi_calculation_type.name')
      audit_columns_headers.push('KPI Calculation Type')
      unless kpi_calculation_type_id.blank?
        kpi_calculation_type_values = kpi_calculation_type_id
        @audits = @audits.where(kpi_calculation_type_id: kpi_calculation_type_values.split(''))
      end
    end

    if selected_columns.include?('Top Layer KPI Ref')
      audit_columns.push('departmental_sdbip.top_layer_kpi_ref')
      audit_columns_headers.push('Top Layer KPI Ref')
    end
    if selected_columns.include?('Baseline')
      audit_columns.push('departmental_sdbip.baseline')
      audit_columns_headers.push('Baseline')
      unless baseline.blank?
        baseline_values = baseline
        @audits = @audits.where(baseline: baseline_values.split(''))

      end
    end
    if selected_columns.include?('Ward')
      audit_columns.push('departmental_sdbip.ward.name')
      audit_columns_headers.push('Ward')
      unless ward_id.blank?
        ward_values = ward_id
        @audits = @audits.where(wards: ward_values.split(''))

      end

    end
    if selected_columns.include?('Area')
      audit_columns.push('departmental_sdbip.area.name')
      audit_columns_headers.push('Area')
      unless area_id.blank?
        area_values = area_id
        @audits = @audits.where(areas: area_values.split(''))

      end
    end

    if selected_columns.include?('Budget')
      audit_columns.push('departmental_sdbip.budget')
      audit_columns_headers.push('Budget')
    end
    if 'KPI'.in?selected_columns
      audit_columns.push('departmental_sdbip.kpi')
      audit_columns_headers.push('KPI')
      unless kpi.blank?
        kpi_values = kpi
        @audits = @audits.where(id: kpi_values.split(''))

      end
    end
    if selected_columns.include?('KPA')
      audit_columns.push('departmental_sdbip.kpa.name')
      audit_columns_headers.push('KPA')
      unless national_kpa_id.blank?
        kpa_values = kpa_values
        @audits = @audits.where(kpa_id: kpa_values.split(''))

      end
    end
    if selected_columns.include?('Previous Year Actual Performance')
      audit_columns.push('departmental_sdbip.past_year_performance')
      audit_columns_headers.push('Previous Year Actual Performance')

      unless past_year_performance.blank?
        past_year_performance_values = past_year_performance_values
        @audits = @audits.where(id: past_year_performance_values)

      end
    end
    if selected_columns.include?('Provincial Strategic Objectives')
      audit_columns.push('departmental_sdbip.provincial_strategic_outcome.name')
      audit_columns_headers.push('Provincial Strategic Objectives')
      unless provincial_strategic_outcome_id.blank?
        provincial_strategic_outcome_values = provincial_startegic_id
        @audits = @audits.where(provincial_strategic_outcome_id: provincial_strategic_outcome_values.split(''))

      end
    end
    if selected_columns.include?('Pre-determined Objectives')
      audit_columns.push('departmental_sdbip.predetermined_objective.name')
      audit_columns_headers.push('Pre-determined Objectives')

      unless predetermined_objective_id.blank?
        predetermined_objectives_values = predetermined_objective_id
        @audits = @audits.where(predetermined_objective_id: predetermined_objectives_values.split(''))

      end
    end
    if selected_columns.include?('GFS Classification')
      audit_columns.push('departmental_sdbip.mscore_classification.name')
      audit_columns_headers.push('GFS Classification')
      unless mscore_classification_id.blank?
        mscore_classification_values = mscore_classification_id
        @audits = @audits.where(mscore_classification_id: mscore_classification_values.split(''))

      end
    end

    if selected_columns.include?('NDP Objectives')
      audit_columns.push('departmental_sdbip.ndp_objective.name')
      audit_columns_headers.push('NDP Objectives')
      unless ndp_objective_id.blank?
        ndp_objective_values = ndp_objective_id
        @audits = @audits.where(ndp_objective_id: ndp_objective_values.split(''))

      end
    end

    if selected_columns.include?('Strategic Objectives')
      audit_columns.push('departmental_sdbip.strategic_objective.name')
      audit_columns_headers.push('Strategic Objectives')
      unless strategic_objective_id.blank?
        strategic_objective_values = strategic_objective_id
        @audits = @audits.where(strategic_objective_id: strategic_objective_values.split(''))
      end
    end

    if selected_columns.include?('Impact')
      audit_columns.push('departmental_sdbip.impact')
      audit_columns_headers.push('Impact')
      unless impact.blank?
        impact_values = impact_values
        @audits = @audits.where(impact: impact_values.split(''))

      end
    end
    if selected_columns.include?('Proof of evidence')
      audit_columns.push('departmental_sdbip.source_of_evidence')
      audit_columns_headers.push('Proof of Evidence')
      unless source_of_evidence.blank?
        source_of_evidence_values = source_of_evidence
        @audits = @audits.where(source_of_evidence: source_of_evidence_values.split(''))

      end
    end
    if selected_columns.include?('Unit of Measurement')
      audit_columns.push('departmental_sdbip.unit_of_measurement')
      audit_columns_headers.push('Unit of Measurement')
      unless unit_of_measurement.blank?
        unit_of_measurement_values = unit_of_measurement_values
        @audits = @audits.where(unit_of_measurement: unit_of_measurement_values.split(''))
      end

    end
    if selected_columns.include?('National Outcome')
      audit_columns.push('departmental_sdbip.national_outcome.name')
      audit_columns_headers.push('National Outcome')
    end
    if selected_columns.include?('Annual Target')
      audit_columns.push('departmental_sdbip.annual_target')
      audit_columns_headers.push('Annual Target')
      unless annual_target.blank?
        annual_target_values = annual_target
        @audits = @audits.where(annual_target: annual_target_values.split(''))

      end
    end
    if selected_columns.include?('Reporting Category')
      audit_columns.push('departmental_sdbip.reporting_category.name')
      audit_columns_headers.push('Reporting Category')
    end
    if selected_columns.include?('IDP Ref')
      audit_columns.push('departmental_sdbip.idp_ref')
      audit_columns_headers.push('IDP Ref')
    end
    if selected_columns.include?('Performance Standard')
      audit_columns.push('departmental_sdbip.performance_standard')
      audit_columns_headers.push('Performance Standard')
      unless performance_standard.blank?
        @audits = @audits.where(performance_standard: performance_standard)
      end
    end
    if selected_columns.include?('Performance Comment')
      audit_columns.push('departmental_sdbip.performance_comments')
      audit_columns_headers.push('Performance Comment')
    end
    if selected_columns.include?('Corrective Measures')
      audit_columns.push('departmental_sdbip.corrective_measures')
      audit_columns_headers.push('Corrective Measures')
    end
    if selected_columns.include?('Target')
      audit_columns.push('departmental_sdbip.target')
      audit_columns_headers.push('Target')
    end
    if selected_columns.include?('Proof of evidence')
      audit_columns.push('departmental_sdbip.first_quarter_poe')
      audit_columns_headers.push('Proof of evidence')
    end
    if selected_columns.include?('KPI Target Type')
      audit_columns.push('departmental_sdbip.kpi_calculation_type.name')
      audit_columns_headers.push('KPI Target Type')
    end
    if selected_columns.include?('Target, Actual and Results') && !start_date.blank? && !end_date.blank?
      @kpi_results = KpiResult.where('extract(month from period) >= ? AND extract(year from period) >= ? AND extract(month from period) <= ? AND extract(year from period) <= ?', start_date.to_date.month, start_date.to_date.year, end_date.to_date.month, end_date.to_date.year)
    else
      @kpi_results = KpiResult.all
    end
    $results = @kpi_results
    $selected_array_of_values = audit_columns
    $selected_array_of_headers = audit_columns_headers
    @audit_logs = @audits
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      column_names = ['KPI Ref no.', 'KPI', 'Department', 'Subdepartment', 'KPA', 'KPI Type', 'KPI Owner', 'Strategic Objectives', 'Baseline', 'Annual Target', 'Revised Target', 'Area', 'Ward', 'Source of Evidence', 'Unit of Measurement']
      csv << column_names
      all.each do |departmental_sdbip|
        csv << [departmental_sdbip.kpi_ref_number, departmental_sdbip.kpi, departmental_sdbip.department_name, departmental_sdbip.subdepartment_name, departmental_sdbip.kpa_name, departmental_sdbip.kpi_type_name, departmental_sdbip.kpi_owner_name, departmental_sdbip.strategic_objective_name, departmental_sdbip.baseline, departmental_sdbip.annual_target, departmental_sdbip.revised_target, departmental_sdbip.areas, departmental_sdbip.wards, departmental_sdbip.source_of_evidence, departmental_sdbip.unit_of_measurement]
      end
    end
  end

  def self.search(subdepartment_id, kpi_type_id, _start_date, _end_date)
    @sdbips = DepartmentalSdbip.all
    unless subdepartment_id.blank?
      @sdbips = @sdbips.where(['subdepartment_id = ?', subdepartment_id])
    end
    unless kpi_type_id.blank?
      @sdbips = @sdbips if kpi_type_id == '0'
      if kpi_type_id.to_i > 0
        @sdbips = @sdbips.where(['kpi_type_id = ?', kpi_type_id])
      end
    end
    @departmental_sdbips = @sdbips
  end
end
