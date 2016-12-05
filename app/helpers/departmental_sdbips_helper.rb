module DepartmentalSdbipsHelper
  def options_for_group_selection
    options_for_select([%w(Department 0), ['Performance Standard', '1'], %w(KPA 2)])
  end

  def options_for_graph_selection
    options_for_select([['Bar Graph', '0'], ['Pie Chart', '1']])
  end

  def options_for_performance_standard
    options_for_select(['KPI Not Yet Measured', 'KPI Not Met', 'KPI Almost Met', 'KPI Met', 'KPI Well Met', 'KPI Extremely Well Met'])
  end

  def first_quarter
    Date.today.month >= 9 && Date.today <= Date.new(Date.today.year,11, 15)
  end

  def second_quarter
    Date.today >= Date.new(Date.today.year,12,15) && Date.today.month < 2
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
end
