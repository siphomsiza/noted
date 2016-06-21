class ReportPdf < Prawn::Document

  def initialize(sdbips)
    super()
    @departmental_sdbips = sdbips

    @departmental_sdbips = DepartmentalSdbip.all
    @kpi_not_yet_measured = DepartmentalSdbip.where("performance_standard = ?", "KPI Not Yet Measured")

    @kpi_measured = DepartmentalSdbip.where("performance_standard != ?", "KPI Not Yet Measured")
    @kpi_not_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Not Met")
    @kpi_almost_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Almost Met")
    @kpi_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Met")
    @kpi_well_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Well Met")
    @kpi_extremely_well_met = DepartmentalSdbip.where("performance_standard = ?", "KPI Extremely Well Met")

    @get_all_kpis = DepartmentalSdbip.all

    @get_performance_standard = DepartmentalSdbip.where("performance_standard = ?", @performance_standard)

    @get_municipal_manager = DepartmentalSdbip.where("department_id = ?", 1)
    @get_financial_services = DepartmentalSdbip.where("department_id = ?", 2)
    @get_community_services = DepartmentalSdbip.where("department_id = ?", 3)
    @get_corporate_services = DepartmentalSdbip.where("department_id = ?", 4)
    @get_technical_services = DepartmentalSdbip.where("department_id = ?", 5)
    @get_planning_and_development = DepartmentalSdbip.where("department_id = ?", 6)

    @get_basic_service_delivery = DepartmentalSdbip.where("kpa_id = ?", 1)
    @get_good_governance = DepartmentalSdbip.where("kpa_id = ?", 2)
    @get_economic_development = DepartmentalSdbip.where("kpa_id = ?", 3)
    @get_financial_viability = DepartmentalSdbip.where("kpa_id = ?", 4)
    @get_municipal_transformation = DepartmentalSdbip.where("kpa_id = ?", 5)

    @kpi_not_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Met'")
    @kpi_well_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_municipal_manager = DepartmentalSdbip.where("department_id = 1 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Met'")
    @kpi_well_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_financial_services = DepartmentalSdbip.where("department_id = 2 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Met'")
    @kpi_well_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_community_services = DepartmentalSdbip.where("department_id = 3 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Met'")
    @kpi_well_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_corporate_services = DepartmentalSdbip.where("department_id = 4 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Met'")
    @kpi_well_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_technical_services = DepartmentalSdbip.where("department_id = 5 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Met'")
    @kpi_well_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_planning_and_development = DepartmentalSdbip.where("department_id = 6 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_basic_service_delivery = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_basic_service_delivery = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_basic_service_delivery = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Met'")
    @kpi_well_met_basic_service_delivery  = DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_basic_service_delivery= DepartmentalSdbip.where("kpa_id = 1 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Met'")
    @kpi_well_met_good_governance  = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_good_governance = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_economic_development = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_economic_development = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_economic_development = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Met'")
    @kpi_well_met_economic_development  = DepartmentalSdbip.where("kpa_id = 3 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_economic_development = DepartmentalSdbip.where("kpa_id = 2 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Met'")
    @kpi_well_met_financial_viability  = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_financial_viability = DepartmentalSdbip.where("kpa_id = 4 AND performance_standard = 'KPI Extremely Well Met'")

    @kpi_not_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Not Met'")
    @kpi_almost_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Almost Met'")
    @kpi_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Met'")
    @kpi_well_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Well Met'")
    @kpi_extremely_well_met_municipal_transformation = DepartmentalSdbip.where("kpa_id = 5 AND performance_standard = 'KPI Extremely Well Met'")

    header
    text_content
    summary_of_results_header
    summary_of_results_table
    summary_per_department_header
    summary_per_department_table
    summary_per_kpa_header
    summary_per_kpa_table
    sdbip_header
    sdbip_table
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/header.png", width: 250, height: 150, vposition: :top, position: :center
    move_down(100)
  end

  def text_content
    text "Mkhondo Municipality", size: 30, style: :bold, align: :center
    move_down(40)

    text "Performance Management Report", size: 30, style: :bold, align: :center
    move_down(400)

    text "Table of Contents", size: 30, style: :bold, align: :center
    move_down(50)

    text "1. Legislative Background Governing Performance Management", size: 16, align: :center
    move_down(15)

    text "2. Purpose of the Report", size: 16, align: :center
    move_down(15)

    text "3. Challenges on the current Performance Management Structure", size: 16, align: :center
    move_down(15)

    text "4.  Steps to improve the Performance Management Capacity", size: 16, align: :center
    move_down(15)

    text "5. Current Status and Structure", size: 16, align: :center
    move_down(15)

        text "6. Summary of Results", size: 16, align: :center
    move_down(15)

        text "7. Summary of Results per Department", size: 16, align: :center
    move_down(15)

        text "8. Summary of Results per KPA", size: 16, align: :center
    move_down(15)

        text "9. Mid Term Report", size: 16, align: :center
    move_down(400)

    text "1. Legislative Background Governing Performance Management", size: 16, style: :bold
    move_down(30)

    text "Section 38 of the Municipal Systems Act requires that: 
    A municipality must—
    (a) establish a performance management system that is—
    (i) commensurate with its resources;
    (ii) best suited to its circumstances; and
    (iii) In line with the priorities, objectives. indicators and targets contained in its integrated development plan; 
    (b) promote a culture of performance management among its political structures, political office bearers and councillors and in its administration, and;
    (c) Administer its affairs in an economical, effective, efficient and accountable manner.
    Section 40 of the Municipal Systems Act requires that: A municipality must establish mechanisms to monitor and review its performance management system. Section 46 of the Municipal Systems Act states that: - A municipality must prepare for each financial year an annual report consisting of—
    (a) a performance report reflecting—
    (i) the municipality’s, and any service provider’s, performance during that financial year, also in comparison with targets of and with performance in the previous financial year; 
    (ii) the development and service delivery priorities and the performance targets set by the municipality for the following financial year; 
    (iii) Measures that were or are to be taken to improve performance.", size: 12
    move_down(30)

    text "2. Purpose of the Report", size: 16, style: :bold
    move_down(15)

    text "The purpose of this report is to communicate;
    The 2015/16 Midterm SDBIP Performance results and;
    Challenges within the Performance Management Unit
    Proposed recommendations for improvements of the PMS Division and processes.", size: 12
    move_down(30)

    text "3. Challenges on the current Performance Management Structure", size: 16, style: :bold
    move_down(20)

    text "Identify challenges and document and link to legislative requirements", size: 12
    move_down(200)

    text "4.  Steps to improve the Performance Management Capacity", size: 16, style: :bold
    move_down(30)

    text "Identify and recommend and link to legislative requirements e.g. 

    Section 5.3 Guidance on priority capacity building activities of the Performance Information Handbook states that; “Building organisational capacity for the management of performance information requires a combination of formal training, internal capacity development initiatives and ‘hands-on’ practice”.
    It is therefore important that the organisation provides for strong central coordination of the PI function. This coordinating capacity must be placed at a senior level, as is required by the Regulations on Programme Performance Information.
    General capacity requirements include;
    Administrative time to review and understand handbook requirements, undertake the development of a medium to long term PI strategy, draft the PI Plan and an organisational PI Manual and coordinate and implement the various activities proposed
    Administrative knowledge of all legislation and regulations that impact on PI management and related data management", size: 12
    move_down(30)

    text "5. Current Status and Structure", size: 16, style: :bold
    move_down(15)

    text "Document action plan.", size: 12
    move_down(400)

  end

  def summary_of_results_header
    text "6. Summary of Results", size: 16, style: :bold, align: :center
    move_down(10)
  end

  def summary_of_results_table
    table summary_of_results_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end

    move_down(50)
  end

  def summary_per_department_header
    text "7. Summary of Results per Department", size: 16, style: :bold, align: :center
    move_down(10)
  end

  def summary_per_department_table
    table summary_per_department_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
    move_down(150)
  end

  def summary_per_kpa_header
    text "8. Summary of Results per KPA", size: 16, style: :bold, align: :center
    move_down(20)
  end

  def summary_per_kpa_table
    table summary_per_kpa_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
    move_down(50)
  end

  def sdbip_header
    text "9. Mid Term Report", size: 16, style: :bold, align: :center
    move_down(20)
  end

  def sdbip_table
    table sdbip_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
  end


  def summary_of_results_rows
    [['', 'All KPIs', 
      'All KPI Percentages (%)', 
      'Total KPIs Measured', 
      'Measured KPIs Percentages (%)'],
      ['KPI Not Yet Measured',
        @kpi_not_yet_measured.count,
        (@kpi_not_yet_measured.count * @get_all_kpis.count)/100,
        '',
        ''],
      ['KPI Not Met',
        @kpi_not_met.count,
        (@kpi_not_met.count * @get_all_kpis.count)/100,
        (@kpi_measured.count * @kpi_not_met.count)/100,
        (@kpi_measured.count * @kpi_not_met.count)/100],
      ['KPI Almost Met',
        @kpi_almost_met.count,
        (@kpi_almost_met.count * @get_all_kpis.count)/100,
        (@kpi_measured.count * @kpi_almost_met.count)/100,
        (@kpi_measured.count * @kpi_almost_met.count)/100],
      ['KPI Met',
        @kpi_met.count,
        (@kpi_met.count * @get_all_kpis.count)/100,
        (@kpi_measured.count * @kpi_met.count)/100,
        (@kpi_measured.count * @kpi_met.count)/100],
      ['KPI Well Met',
        @kpi_well_met.count,
        (@kpi_well_met.count * @get_all_kpis.count)/100,
        (@kpi_measured.count * @kpi_well_met.count)/100,
        (@kpi_measured.count * @kpi_well_met.count)/100],
        ['KPI Extremely Well Met',
        @kpi_extremely_well_met.count,
        (@kpi_extremely_well_met.count * @get_all_kpis.count)/100,
        (@kpi_measured.count * @kpi_extremely_well_met.count)/100,
        (@kpi_measured.count * @kpi_extremely_well_met.count)/100]]
  end

  def summary_per_department_rows
    [['', 
      'Mkhondo Municipality (%)', 
      'Municipal Managers Office (%)', 
      'Financial Services (%)',
      'Community Services (%)',
      'Corporate Services (%)',
      'Technical Services (%)',
      'Planning and Development (%)'],
      ['KPI Not Met',
        (@kpi_not_met.count * 100)/@get_all_kpis.count,
        (@kpi_not_met_municipal_manager.count * 100)/@get_municipal_manager.count,
        (@kpi_not_met_financial_services.count * 100)/@get_financial_services.count,
        (@kpi_not_met_community_services.count * 100)/@get_community_services.count,
        (@kpi_not_met_corporate_services.count * 100)/@get_corporate_services.count,
        (@kpi_not_met_technical_services.count * 100)/@get_technical_services.count,
        (@kpi_not_met_planning_and_development.count * 100)/@get_planning_and_development.count],
      ['KPI Almost Met',
        (@kpi_almost_met.count * 100)/@get_all_kpis.count,
        (@kpi_almost_met_municipal_manager.count * 100)/@get_municipal_manager.count,
        (@kpi_almost_met_financial_services.count * 100)/@get_financial_services.count,
        (@kpi_almost_met_community_services.count * 100)/@get_community_services.count,
        (@kpi_almost_met_corporate_services.count * 100)/@get_corporate_services.count,
        (@kpi_almost_met_technical_services.count * 100)/@get_technical_services.count,
        (@kpi_almost_met_planning_and_development.count * 100)/@get_planning_and_development.count],
      ['KPI Met',
        (@kpi_met.count * 100)/@get_all_kpis.count,
        (@kpi_met_municipal_manager.count * 100)/@get_municipal_manager.count,
        (@kpi_met_financial_services.count * 100)/@get_financial_services.count,
        (@kpi_met_community_services.count * 100)/@get_community_services.count,
        (@kpi_met_corporate_services.count * 100)/@get_corporate_services.count,
        (@kpi_met_technical_services.count * 100)/@get_technical_services.count,
        (@kpi_met_planning_and_development.count * 100)/@get_planning_and_development.count],
      ['KPI Well Met',
        (@kpi_well_met.count * 100)/@get_all_kpis.count,
        (@kpi_well_met_municipal_manager.count * 100)/@get_municipal_manager.count,
        (@kpi_well_met_financial_services.count * 100)/@get_financial_services.count,
        (@kpi_well_met_community_services.count * 100)/@get_community_services.count,
        (@kpi_well_met_corporate_services.count * 100)/@get_corporate_services.count,
        (@kpi_well_met_technical_services.count * 100)/@get_technical_services.count,
        (@kpi_well_met_planning_and_development.count * 100)/@get_planning_and_development.count],
        ['KPI Extremely Well Met',
        (@kpi_extremely_well_met.count * 100)/@get_all_kpis.count,
        (@kpi_extremely_well_met_municipal_manager.count * 100)/@get_municipal_manager.count,
        (@kpi_extremely_well_met_financial_services.count * 100)/@get_financial_services.count,
        (@kpi_extremely_well_met_community_services.count * 100)/@get_community_services.count,
        (@kpi_extremely_well_met_corporate_services.count * 100)/@get_corporate_services.count,
        (@kpi_extremely_well_met_technical_services.count * 100)/@get_technical_services.count,
        (@kpi_extremely_well_met_planning_and_development.count * 100)/@get_planning_and_development.count]]
  end

  def summary_per_kpa_rows
    [['', 
      'Basic Service Delivery (%)', 
      'Good Governance and Public Participation (%)', 
      'Local Economic Development (%)',
      'Municipal Finacial Viability and Management (%)',
      'Municipal Transformation and Institutional Development (%)'],
      ['KPI Not Met',
        (@kpi_not_met_basic_service_delivery.count * 100)/@get_basic_service_delivery.count,
        (@kpi_not_met_good_governance.count * 100)/@get_good_governance.count,
        (@kpi_not_met_economic_development.count * 100)/@get_economic_development.count,
        (@kpi_not_met_financial_viability.count * 100)/@get_financial_viability.count,
        (@kpi_not_met_municipal_transformation.count * 100)/@get_municipal_transformation.count],
      ['KPI Almost Met',
        (@kpi_almost_met_basic_service_delivery.count * 100)/@get_basic_service_delivery.count,
        (@kpi_not_met_good_governance.count * 100)/@get_good_governance.count,
        (@kpi_almost_met_economic_development.count * 100)/@get_economic_development.count,
        (@kpi_almost_met_financial_viability.count * 100)/@get_financial_viability.count,
        (@kpi_almost_met_municipal_transformation.count * 100)/@get_municipal_transformation.count],
      ['KPI Met',
        (@kpi_met_basic_service_delivery.count * 100)/@get_basic_service_delivery.count,
        (@kpi_met_good_governance.count * 100)/@get_good_governance.count,
        (@kpi_met_economic_development.count * 100)/@get_economic_development.count,
        (@kpi_met_financial_viability.count * 100)/@get_financial_viability.count,
        (@kpi_met_municipal_transformation.count * 100)/@get_municipal_transformation.count],
      ['KPI Well Met',
        (@kpi_well_met_basic_service_delivery.count * 100)/@get_basic_service_delivery.count,
        (@kpi_well_met_good_governance.count * 100)/@get_good_governance.count,
        (@kpi_well_met_economic_development.count * 100)/@get_economic_development.count,
        (@kpi_well_met_financial_viability.count * 100)/@get_financial_viability.count,
        (@kpi_well_met_municipal_transformation.count * 100)/@get_municipal_transformation.count],
        ['KPI Extremely Well Met',
        (@kpi_extremely_well_met_basic_service_delivery.count * 100)/@get_basic_service_delivery.count,
        (@kpi_extremely_well_met_good_governance.count * 100)/@get_good_governance.count,
        (@kpi_extremely_well_met_economic_development.count * 100)/@get_economic_development.count,
        (@kpi_extremely_well_met_financial_viability.count * 100)/@get_financial_viability.count,
        (@kpi_extremely_well_met_municipal_transformation.count * 100)/@get_municipal_transformation.count]]
  end

  def sdbip_rows
    [['', 'Department', 
      'Subdepartment', 
      'Predetermined Objectives',
      'KPI Owner']] +
      @departmental_sdbips.map do |sdbip|
      [sdbip.id, 
        sdbip.department.name, 
        sdbip.subdepartment.subdepartment_name, 
        sdbip.predetermined_objective.name, 
        sdbip.kpi_owner.name]
    end
  end


end