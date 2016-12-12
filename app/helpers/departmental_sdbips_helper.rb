module DepartmentalSdbipsHelper
  Alpha26 = ("a".."z").to_a
  def to_alphabet(q)
    return "" if self < 1
    s, q = "", self
    loop do
      q, r = (q - 1).divmod(26)
      s.prepend(Alpha26[r])
      break if q.zero?
    end
    s.upcase
  end
  def get_results(result)
    if result == "KPI Not Yet Measured"
      return 'highlight_kpi_not_yet_measured_cell'
    end
    if result == "KPI Not Met"
      return 'highlight_kpi_not_met_cell'
    end
    if result == "KPI Almost Met"
      return 'highlight_kpi_almost_met_cell'
    end
    if result == "KPI Met"
      return 'highlight_kpi_met_cell'
    end
    if result == "KPI Well Met"
      return 'highlight_kpi_well_met_cell'
    end
    if result == "KPI Extremely Well Met"
      return 'highlight_kpi_extremely_well_met_cell'
    end
  end
  def evaluate_results(records)
    @records = records
    if departmental_sdbip.kpi_owner_id.blank? || !departmental_sdbip.kpi_owner.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.kpi_owner.name', '')
      end
    end
    if departmental_sdbip.predetermined_objective_id.blank? || !departmental_sdbip.predetermined_objective.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.predetermined_objective.name', '')
      end
    end
    if departmental_sdbip.mscore_classification_id.blank? || !departmental_sdbip.mscore_classification.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.mscore_classification.name', '')
      end
    end
    if departmental_sdbip.strategic_objective_id.blank? || !departmental_sdbip.strategic_objective.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.strategic_objective.name', '')
      end
    end
    if departmental_sdbip.ndp_objective_id.blank? || !departmental_sdbip.ndp_objective.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.ndp_objective.name', '')
      end
    end
    if departmental_sdbip.risk_rating_id.blank? || !departmental_sdbip.risk_rating.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.risk_rating.name', '')
      end
    end
    if departmental_sdbip.kpi_concept_id.blank? || !departmental_sdbip.kpi_concept.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.kpi_concept.name', '')
      end
    end
    if departmental_sdbip.kpi_type_id.blank? || !departmental_sdbip.kpi_type.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.kpi_type.name', '')
      end
    end
    if departmental_sdbip.kpa_id.blank? || !departmental_sdbip.kpa.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.kpa.name', '')
      end
    end
    if departmental_sdbip.reporting_category_id.blank? || !departmental_sdbip.reporting_category.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.reporting_category.name', '')
      end
    end
    if departmental_sdbip.kpi_calculation_type_id.blank? || !departmental_sdbip.kpi_calculation_type.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.kpi_calculation_type.name', '')
      end
    end
    if departmental_sdbip.provincial_strategic_outcome_id.blank? || !departmental_sdbip.provincial_strategic_outcome.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.provincial_strategic_outcome.name', '')
      end
    end
    if departmental_sdbip.provincial_strategic_outcome_id.blank? || !departmental_sdbip.provincial_strategic_outcome.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.provincial_strategic_outcome.name', '')
      end
    end
    if departmental_sdbip.national_outcome_id.blank? || !departmental_sdbip.national_outcome.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.national_outcome.name', '')
      end
    end
    if departmental_sdbip.kpi_target_type_id.blank? || !departmental_sdbip.kpi_target_type.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.kpi_target_type.name', '')
      end
    end
    if departmental_sdbip.mtas_indicator_id.blank? || !departmental_sdbip.mtas_indicator.present?
      @records.each do |s|
        s.gsub!('departmental_sdbip.mtas_indicator.name', '')
      end
    end
  end
  def options_for_group_selection
    options_for_select([%w(Department 0), ['Performance Standard', '1'], %w(KPA 2)])
  end

  def options_for_graph_selection
    options_for_select([['Bar Graph', '0'], ['Pie Chart', '1']])
  end

  def options_for_performance_standard
    options_for_select(['KPI Not Yet Measured', 'KPI Not Met', 'KPI Almost Met', 'KPI Met', 'KPI Well Met', 'KPI Extremely Well Met'])
  end

  def current_target
    if Date.today.month >= 9 && Date.today <= Date.new(Date.today.year,12, 15)
      return @departmental_sdbip.first_quarter_target
    elsif Date.today > Date.new(Date.today.year,12,15) && Date.today.month < 2
      return @departmental_sdbip.second_quarter_target
    elsif Date.today.month >= 3 && Date.today <= Date.new(Date.today.year,4,15)
      return @departmental_sdbip.third_quarter_target
    elsif Date.today.month >= 6 && Date.today <= Date.new(Date.today.year,7,15)
      return @departmental_sdbip.fourth_quarter_target
    end
  end

  def first_quarter
    Date.today.month >= 9 && Date.today <= Date.new(Date.today.year,12, 15)
  end

  def second_quarter
    Date.today > Date.new(Date.today.year,12,15) && Date.today.month < 2
  end

  def third_quarter
    Date.today.month >= 3 && Date.today <= Date.new(Date.today.year,4,15)
  end

  def fourth_quarter
    Date.today.month >= 6 && Date.today <= Date.new(Date.today.year,7,15)
  end

  def editors
    current_user && (current_user.admin? || current_user.super_admin?)
  end

  def kpi_actual_to_date
    @departmental_sdbip.kpi_results.sum(:actual, group: :departmental_sdbip_id) # ||= 0
  end
  def kpi_not_yet_measured(sdbips)
    return sdbips.where(performance_standard: "KPI Not Yet Measured").count
  end
  def kpi_not_met(sdbips)
    return sdbips.where(performance_standard: "KPI Not Met").count
  end
  def kpi_almost_met(sdbips)
    return sdbips.where(performance_standard: "KPI Almost Met").count
  end
  def kpi_met(sdbips)
    return sdbips.where(performance_standard: "KPI Met").count
  end
  def kpi_well_met(sdbips)
    return sdbips.where(performance_standard: "KPI Well Met").count
  end
  def kpi_extremely_well_met(sdbips)
    return sdbips.where(performance_standard: "KPI Extremely Well Met").count
  end
  def total_kpis(sdbips)
    return sdbips.count
  end
  def sdbip_year
    current_sdbip_year = nil
    #if Date.today.month >= 7 && ((Date.today + 12.months) <= 6 )
      current_sdbip_year = "#{Date.today.year}/#{(Date.today + 12.months).year}"
    #end
    return current_sdbip_year
  end
end
