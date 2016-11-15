# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record/fixtures'
User.create!( firstname: "Donald",
              surname: "Maphori",
              email: "dmaphori@lepellenkumpi.co.za",
              password: "donald1234",
              title: "Mr",
              mobile: Faker::Number.number(10),
              landline: Faker::Number.number(10),
              id_number: Faker::Number.number(13),
              birth_date: Time.now.strftime("%dd/%mm/%YYYY"),
              location: "Lepelle Nkumpi Local Municipality",
              password_confirmation: "donald1234",
              super_admin: true,
              activated: true,status: "Active",
              activated_at: Time.zone.now)
User.create!( firstname: "Casey Abram",
                            surname: "Seabela",
                            username: "caseabela",
                            email: "casey@sableassets.com",
                            password: "sableassets",
                            title: "Mr",
                            mobile: "0764338939",
                            landline: "0112563984",
                            id_number: Faker::Number.number(13),
                            birth_date: Time.now.strftime("%dd/%mm/%YYYY"),
                            location: "Riversands Incubation Hub",
                            password_confirmation: "sableassets",
                            super_admin: true,
                            activated: true,status: "Active",
                            activated_at: Time.zone.now)

MasterSetup.create!(
  municipality: "Lepelle Nkumpi Local Municipality",
  logo: File.open(File.join(Rails.root,'/app/assets/images','lepelle-logo.jpg')),# File.open("../app/assets/images/mkhondo-logo.png"),
  province: "Limpopo",
  latitude: -24.2585 ,
  longitude: 29.6499,
  address: 'Lepelle Nkumpi Local Municipality<br />Lebowakgomo-BA, 0737<br />Limpopo, South Africa'
)

landline=Faker::Number.number(10)
mobile=Faker::Number.number(10)
Department.create!(name: "Municipal Manager's Office",
  tel_no: landline,
  fax_no:mobile)

Department.create!(name: "Financial Services",
  tel_no:landline,
  fax_no: mobile)

Department.create!(name: "Community Services",
  tel_no:landline,
  fax_no:mobile)

Department.create!(name: "Corporate Services",
  tel_no:landline,
  fax_no: mobile)

Department.create!(name: "Technical Services",
  tel_no:landline,
  fax_no: mobile)

Department.create!(name: "Planning and Development",
  tel_no:landline,
  fax_no: mobile)
Department.create!(name: "Department in the MM's Office",
  tel_no:landline,
  fax_no: mobile)

Subdepartment.create!(name: "Municipal Manager's Office", department_id: "1")

Subdepartment.create!(name: "Internal Audit", department_id: "7",)
Subdepartment.create!(name: "Performance Management Unit", department_id: "7")
Subdepartment.create!(name: "Legal Services", department_id: "7")
Subdepartment.create!(name: "Forestry", department_id: "7")

Subdepartment.create!(name: "Budget And Financial Reporting", department_id: "2")
Subdepartment.create!(name: "Expenditure", department_id: "2")
Subdepartment.create!(name: "ICT", department_id: "2")
Subdepartment.create!(name: "Revenue", department_id: "2")
Subdepartment.create!(name: "Supply Chain Management", department_id: "2")

Subdepartment.create!(name: "Department Of Community Service", department_id: "3")

Subdepartment.create!(name: "Corporate Services", department_id: "4")

Subdepartment.create!(name: "Technical Services", department_id: "5")

Subdepartment.create!(name: "Planning and Development", department_id: "6")
Subdepartment.create!(name: "Human Settlements", department_id: "6")
Subdepartment.create!(name: "Building Control", department_id: "6")

Subdepartment.create!(name: "Executive Mayor's Office", department_id: "1")

Subdepartment.create!(name: "Finance", department_id: "2")

Subdepartment.create!(name: "Risk", department_id: "7")

#directory = File.join(File.dirname(__FILE__), '/migrate/data')
# From lookup_classes
#ActiveRecord::FixtureSet.create_fixtures(File.join(Rails.root, 'db/migrate/data'), 'kpa')
# From lookups
#ActiveRecord::FixtureSet.create_fixtures(File.join(Rails.root, 'db/migrate/data'), 'strategic_objectives')

CSV.foreach('db_lepelle_nkumpi/data/kpa.csv', headers: true, :col_sep => ',') do |row|
  Kpa.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/strategic_objectives.csv', headers: true, :col_sep => ',') do |row|
  StrategicObjective.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/risk_ratings.csv', headers: true, :col_sep => ',') do |row|
  RiskRating.create! row.to_hash
end

CSV.foreach('db_lepelle_nkumpi/data/kpi_concept.csv', headers: true, :col_sep => ',') do |row|
  KpiConcept.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/jobs.csv', headers: true, :col_sep => ',') do |row|
  Jobtitle.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/kpi_owners.csv', headers: true, :col_sep => ',') do |row|
  KpiOwner.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/kpi_type.csv', headers: true, :col_sep => ',') do |row|
  KpiType.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/kpi_calculation_types.csv', headers: true, :col_sep => ',') do |row|
  KpiCalculationType.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/ndp_objectives.csv', headers: true, :col_sep => ',') do |row|
  NdpObjective.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/predetermined_objectives.csv', headers: true, :col_sep => ',') do |row|
  PredeterminedObjective.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/national_outcomes.csv', headers: true, :col_sep => ',') do |row|
  NationalOutcome.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/mscore_classification.csv', headers: true, :col_sep => ',') do |row|
  MscoreClassification.create! row.to_hash
end
CSV.foreach('db_lepelle_nkumpi/data/reporting.csv', headers: true, :col_sep => ',') do |row|
  ReportingCategory.create! row.to_hash
end
Ward.create!(name: "All",ward_no: 1,area_id: 1, mun_ref: "Unspecified")

Area.create!(name: "All")

KpiTargetType.create!(name: "Currency", code: "R")
KpiTargetType.create!(name: "Percentage", code: "%")
KpiTargetType.create!(name: "Number", code: "#")

FundingSource.create!(name: "CRR")
FundingSource.create!(name: "Other")
FundingSource.create!(name: "Own Funds")
FundingSource.create!(name: "Bulk Services Levy")
FundingSource.create!(name: "MIG")
FundingSource.create!(name: "External Loans")
FundingSource.create!(name: "Library Grant")
FundingSource.create!(name: "Rehabilitation Fund")
FundingSource.create!(name: "National Electrification Fund")
FundingSource.create!(name: "RBIG")

Heading.create!(term: "Directorate",
  description: "Directorate description",
  category: "General")

Heading.create!(term: "Sub-Directorate",
  description: "Sub-Directorate description",
  category: "General")

Heading.create!(term: "M Score Classification",
  description: "M Score Classification description",
  category: "General")

Heading.create!(term: "GFS Classification",
  description: "GFS Classification description",
  category: "General")

Heading.create!(term: "National Outcome",
  description: "National Outcome description",
  category: "General")

Heading.create!(term: "KPA",
  description: "KPA description",
  category: "General")

Heading.create!(term: "Predetermined Objectives",
  description: "Predetermined Objectives description",
  category: "General")

Heading.create!(term: "NDP Objectives",
  description: "NDP Objectives description",
  category: "General")

Heading.create!(term: "Wards",
  description: "Wards description",
  category: "General")

Heading.create!(term: "Area",
  description: "Area description",
  category: "General")

Heading.create!(term: "KPI Owner",
  description: "KPI owner description",
  category: "General")

Heading.create!(term: "Reporting Category",
  description: "Reporting category description",
  category: "General")

Heading.create!(term: "Risk Rating",
  description: "Risk Rating description",
  category: "Departmental SDBIP")

Heading.create!(term: "Top Layer KPI Ref",
  description: "Top Layer KPI Ref description",
  category: "Departmental SDBIP")

Heading.create!(term: "IDP Ref",
  description: "IDP Ref description",
  category: "Departmental SDBIP")

Heading.create!(term: "IDP Objective",
  description: "IDP Objective description",
  category: "Departmental SDBIP")

Heading.create!(term: "Capital Project",
  description: "Capital Project description",
  category: "Departmental SDBIP")

Heading.create!(term: "KPI Name",
  description: "KPI Name description",
  category: "Departmental SDBIP")

Heading.create!(term: "Unit of Measurement",
  description: "Unit of Measurement description",
  category: "Departmental SDBIP")

Heading.create!(term: "KPI Concept",
  description: "KPI Concept description",
  category: "Departmental SDBIP")

Heading.create!(term: "KPI Type",
  description: "KPI Type description",
  category: "Departmental SDBIP")

Heading.create!(term: "Risk Reg Ref",
  description: "Risk Reg Ref description",
  category: "Departmental SDBIP")

Heading.create!(term: "Risk",
  description: "Risk description",
  category: "Departmental SDBIP")

Heading.create!(term: "Baseline",
  description: "Baseline description",
  category: "Departmental SDBIP")

Heading.create!(term: "Previous Year Actual Performance",
  description: "Previous Year Actual Performance description",
  category: "Departmental SDBIP")

Heading.create!(term: "Performance standard",
  description: "Performance standard description",
  category: "Departmental SDBIP")

Heading.create!(term: "POE",
  description: "POE description",
  category: "Departmental SDBIP")

Heading.create!(term: "MTAS Indicator",
  description: "MTAS Indicator description",
  category: "Departmental SDBIP")

Heading.create!(term: "Annual Target",
  description: "Annual Target description",
  category: "Departmental SDBIP")

Heading.create!(term: "Revised Target",
  description: "Revised Target description",
  category: "Departmental SDBIP")

Heading.create!(term: "Performance Comment",
  description: "Performance Comment description",
  category: "Departmental SDBIP")

Heading.create!(term: "Corrective measures",
  description: "Corrective measures description",
  category: "Departmental SDBIP")

Heading.create!(term: "Update proof of evidence",
  description: "Update proof of evidence description",
  category: "Departmental SDBIP")

Heading.create!(term: "PMS Ref",
  description: "PMS Ref Description",
  category: "Top Layer SDBIP")

Heading.create!(term: "IDP Objective",
  description: "IDP Objective description",
  category: "Top Layer SDBIP")

Heading.create!(term: "KPI Name",
  description: "KPI Name description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Unit of Measurement",
  description: "Unit of Measurement description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Risk",
  description: "Risk description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Baseline",
  description: "Baseline description",
  category: "Top Layer SDBIP")

Heading.create!(term: "POE",
  description: "POE description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Previous Year Actual Performance",
  description: "Previous Year Actual Performance description",
  category: "Top Layer SDBIP")

Heading.create!(term: "MTAS Indicator",
  description: "MTAS Indicator description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Annual Target",
  description: "Annual Target description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Revised Target",
  description: "Revised Target description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Performance Comment",
  description: "Annual Target description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Corrective measures",
  description: "Corrective measures description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Update proof of evidence",
  description: "Update proof of evidence description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Departmental proof of evidence",
  description: "Departmental proof of evidence description",
  category: "Top Layer SDBIP")

Heading.create!(term: "Mun CP Ref",
  description: "Mun CP Ref description",
  category: "Capital Projects")

Heading.create!(term: "IDP Number",
  description: "IDP Number description",
  category: "Capital Projects")

Heading.create!(term: "Vote Number",
  description: "Vote Number description",
  category: "Capital Projects")

Heading.create!(term: "Project Name",
  description: "Project Name description",
  category: "Capital Projects")

Heading.create!(term: "Project Description",
  description: "Project Description description",
  category: "Capital Projects")

Heading.create!(term: "Funding source",
  description: "Funding source description",
  category: "Capital Projects")

Heading.create!(term: "Planned start date",
  description: "Planned start date description",
  category: "Capital Projects")

Heading.create!(term: "Actual start date",
  description: "Actual start date description",
  category: "Capital Projects")

Heading.create!(term: "Actual End Date",
  description: "Actual End Date description",
  category: "Capital Projects")

Heading.create!(term: "Line Item",
  description: "Line Item description",
  category: "Monthly Cashflows")

Heading.create!(term: "Vote number",
  description: "Vote number description",
  category: "Monthly Cashflows")

Heading.create!(term: "Line Item",
  description: "Line Item description",
  category: "Revenue by source")

Heading.create!(term: "Vote number",
  description: "Vote number description",
  category: "Revenue by source")

$i=0
$num = 12
while $i < $num  do
  month_number = 7 + $i
  if month_number <= 12
  month_beginning = Date.new(Date.today.year, month_number)
  month_ending = month_beginning.end_of_month
  period = month_ending.strftime("%d-%b-%Y")
  primary_reminder = period.to_date + 7.days
  primary_closure = period.to_date + 14.days
  secondary_reminder = period.to_date + 7.days
  secondary_closure = period.to_date + 16.days
  else
    month_number -= 12
    month_beginning = Date.new(Date.today.year, month_number)
    month_beginning += 1.year
    month_ending = month_beginning.end_of_month
    period = month_ending.strftime("%d-%b-%Y")
    primary_reminder = period.to_date + 7.days
    primary_closure = period.to_date + 14.days
    secondary_reminder = period.to_date + 7.days
    secondary_closure = period.to_date + 16.days
  end
  SdbipTimePeriod.create!(period: period,primary_reminder: primary_reminder,primary_closure: primary_closure, secondary_reminder: secondary_reminder,secondary_closure: secondary_closure)
   $i +=1
end
  # CSV.foreach('db_lepelle_nkumpi/data/capital.csv', headers: true, :col_sep => ',') do |row|
  #   CapitalProject.create! row.to_hash
  # end
  CSV.foreach('db_lepelle_nkumpi/data/sdbips.csv', headers: true, :col_sep => ',') do |row|
    DepartmentalSdbip.create! row.to_hash
  end