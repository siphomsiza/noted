class DepartmentalSdbip < ActiveRecord::Base
    include PublicActivity::Model
    # tracked owner: ->(controller, model) { controller && controller.current_user }
    ActiveRecord::Base.establish_connection($current_session_db)
    belongs_to :department
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
    has_one :capital_project
    has_many :kpi_results, dependent: :destroy
    accepts_nested_attributes_for :kpi_results, allow_destroy: true
    has_many :assurances, dependent: :destroy
    accepts_nested_attributes_for :assurances, allow_destroy: true

    validates :department_name, :subdepartment_name, :kpi, :kpi_ref_number, presence: true

    def kpi_result_for_form
        collection = kpi_results.where(departmental_sdbip_id: id)
        collection.any? ? collection : kpi_results.build
    end

    def assurance_for_form
        collection = assurances.where(departmental_sdbip_id: id)
        collection.any? ? collection : assurances.build
    end

    # validate :extension_white_list
    def self.import_from_file(file)
        DepartmentalSdbip.import(file)
    end

    class << self
        def import(file)
            case File.extname(file.original_filename)
            when '.csv' then
                CSV.foreach(file.path, headers: true) do |row|
                    departmental_sdbip_hash = row.to_hash
                    departmental_sdbip = DepartmentalSdbip.find_or_create_by(id: departmental_sdbip_hash['id'])
                    departmental_sdbip.save!
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
        handle_asynchronously :import_from_file, priority: 2, run_at: proc { 3.seconds.from_now }, queue: 'departmental_sdbips'
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
        handle_asynchronously :import_from_file, priority: 2, run_at: proc { 3.seconds.from_now }, queue: 'departmental_sdbips'
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
                                 kpi_calculation_type_id, _kpi_target_type_id)

        @audits = DepartmentalSdbip.all
        audit_columns = []
        audit_columns_headers = []

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
        if selected_columns.include?('Department')
            audit_columns.push('departmental_sdbip.department_name')
            audit_columns_headers.push('Department')
            unless department_id.blank?
                departments_value = department_id
                @audits = @audits.where(department_id: departments_value.split(''))
            end
        end

        if selected_columns.include?('Sub-Department')
            audit_columns.push('departmental_sdbip.subdepartment_name')
            audit_columns_headers.push('Sub-Department')
            unless subdepartment_id.blank?
                subdepartments_value = subdepartment_id
                @audits = @audits.where(subdepartment_id: [subdepartments_value.split('')])
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
                @audits = @audits.where(ward_id: ward_values.split(''))

            end

        end
        if selected_columns.include?('Area')
            audit_columns.push('departmental_sdbip.area.name')
            audit_columns_headers.push('Area')
            unless area_id.blank?
                area_values = area_id
                @audits = @audits.where(area_id: area_values.split(''))

            end
        end

        if selected_columns.include?('Capital Project')
            audit_columns.push('departmental_sdbip.capital_project.mun_cp_ref')
            audit_columns_headers.push('Capital Project')
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
                @audits = @audits.where(id: past_year_performance_values.split(''))

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
        if selected_columns.include?('Source of Evidence')
            audit_columns.push('departmental_sdbip.source_of_evidence')
            audit_columns_headers.push('Source of Evidence')
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
        if selected_columns.include?('Target, Actual and Results')
            audit_columns.push('')
            audit_columns_headers.push('Target, Actual and Results')
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
        if selected_columns.include?('KPI Target Type')
            audit_columns.push('kpi_result.kpi_calculation_type.name')
            audit_columns_headers.push('KPI Target Type')
        end
        $selected_array_of_values = audit_columns
        $selected_array_of_headers = audit_columns_headers
        @audit_logs = @audits
    end

    def self.report_to_csv(options = {})
        selected_columns = $selected_array_of_headers
        column_names = selected_columns
        array_of_values = $selected_array_of_values
        CSV.generate(options) do |csv|
          if $selected_array_of_headers.include?("Target, Actual and Results")
            first_headers = []
            $selected_array_of_headers.each do |header|
              if header == "Target Actual and Results"
                first_headers.push('Target, Actual and Results')
              elsif header != "Target, Actual & Results"
                first_headers.push('')
              end
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
              if $selected_array_of_headers.include?("Target, Actual and Results")
                if departmental_sdbip.kpi_results.any?
                  departmental_sdbip.kpi_results.each do |kpi_result|
                    #array_of_values.push('departmental_sdbip.kpi_result');
                  end
                elsif !departmental_sdbip.kpi_results.any?
                  departmental_sdbip.kpi_results.each do |kpi_result|
                    array_of_values.push('');
                  end
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
                               kpi_calculation_type_id, _kpi_target_type_id)

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
            audit_columns.push('departmental_sdbip.subdepartment_name')
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
                @audits = @audits.where(ward_id: ward_values.split(''))

            end

        end
        if selected_columns.include?('Area')
            audit_columns.push('departmental_sdbip.area.name')
            audit_columns_headers.push('Area')
            unless area_id.blank?
                area_values = area_id
                @audits = @audits.where(area_id: area_values.split(''))

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
        if selected_columns.include?('Target, Actual & Results')
            audit_columns.push('')
            audit_columns_headers.push('Target, Actual and Results')
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
        $selected_array_of_values = audit_columns
        $selected_array_of_headers = audit_columns_headers
        @audit_logs = @audits
    end

    def self.to_csv(options = {})
        CSV.generate(options) do |csv|
            column_names = ['KPI Ref no.', 'KPI', 'Department', 'Subdepartment', 'KPA', 'KPI Type', 'KPI Owner', 'Strategic Objectives', 'Baseline', 'Annual Target', 'Revised Target','Area', 'Ward', 'Source of Evidence', 'Unit of Measurement']
            csv << column_names
            all.each do |departmental_sdbip|
                csv << [departmental_sdbip.kpi_ref_number, departmental_sdbip.kpi, departmental_sdbip.department.name, departmental_sdbip.subdepartment.subdepartment_name, departmental_sdbip.kpa.name, departmental_sdbip.kpi_type.name, departmental_sdbip.kpi_owner.name, departmental_sdbip.strategic_objective.name, departmental_sdbip.baseline, departmental_sdbip.annual_target, departmental_sdbip.revised_target, departmental_sdbip.area.name, departmental_sdbip.ward.name, departmental_sdbip.source_of_evidence, departmental_sdbip.unit_of_measurement]
            end
        end
    end

    def self.search(subdepartment_id, kpi_type_id, start_date, end_date)
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

    def self.search_kpi(kpi_id, department_id, subdepartment_id, kpi_type_id, start_date, end_date)
        if department_id && subdepartment_id && kpi_type_id
            where(['kpi_owner_id = ? AND department_id = ? AND subdepartment_id = ? AND kpi_type_id = ?', kpi_id, department_id, subdepartment_id, kpi_type_id])
        end
    end

    def self.search_departmental_kpis(department_id, subdepartment_id, kpi_type_id, start_date, end_date)
        if department_id && subdepartment_id && kpi_type_id
            where(['department_id = ? AND subdepartment_id = ? AND kpi_type_id = ?', department_id, subdepartment_id, kpi_type_id])
        end
    end

    def self.search_subdepartment_kpis(department_id, subdepartment_id, kpi_type_id, start_date, end_date)
        if department_id && subdepartment_id && kpi_type_id
            where(['department_id = ? AND subdepartment_id = ? AND kpi_type_id = ?', department_id, subdepartment_id, kpi_type_id])
        end
    end

    def extension_white_list
        %w(xls xlsx ods csv)
    end
end
