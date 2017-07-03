# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record/fixtures'

User.delete_all
MasterSetup.delete_all
Department.delete_all
Subdepartment.delete_all
Kpa.delete_all
StrategicObjective.delete_all
RiskRating.delete_all
KpiConcept.delete_all
Jobtitle.delete_all
KpiOwner.delete_all
KpiType.delete_all
KpiCalculationType.delete_all
NdpObjective.delete_all
PredeterminedObjective.delete_all
NationalOutcome.delete_all
MscoreClassification.delete_all
Ward.delete_all
Area.delete_all
KpiTargetType.delete_all
FundingSource.delete_all
Heading.delete_all
SdbipTimePeriod.delete_all
MtasIndicator.delete_all
DepartmentalSdbip.delete_all

User.create!( firstname: "Sandiswa",
              surname: "Nqampoyi",
              email: "Sandiswa@sableassets.co.za",
              password: "sableassets",
              title: "Mr",
              mobile: "0832687954",
              landline: "0112563984",
              id_number: Faker::Number.number(13),
              birth_date: Time.now.strftime("%dd/%mm/%YYYY"),
              location: "Riversands Incubation Hub",
              password_confirmation: "sableassets",
              super_admin: true,
              activated: true,status: "Active",
              activated_at: Time.zone.now)
User.create!( firstname: "Sandile",
              surname: "Swana",
              email: "sandile@sableassets.co.za",
              password: "sableassets",
              title: "Mr",
              mobile: "0832687954",
              landline: "0112563984",
              id_number: Faker::Number.number(13),
              birth_date: Time.now.strftime("%dd/%mm/%YYYY"),
              location: "Riversands Incubation Hub",
              password_confirmation: "sableassets",
              super_admin: true,
              activated: true,status: "Active",
              activated_at: Time.zone.now)
User.create!( firstname: "Agnes",
              surname: "Matambanadzo",
              username: "agnes",
              email: "agnesm@armsaudit.co.za",
              password: "sableassets",
              title: "Mrs",
              mobile: "0764338939",
              landline: "0112563984",
              id_number: Faker::Number.number(13),
              birth_date: Time.now.strftime("%dd/%mm/%YYYY"),
              location: "Riversands Incubation Hub",
              password_confirmation: "sableassets",
              super_admin: true,
              activated: true,status: "Active",
              activated_at: Time.zone.now)

User.create!( firstname: "Sipho",
              surname: "Msiza",
              username: "siphosmall@gmail.com",
              email: "siphosmall@gmail.com",
              password: "sableassets",
              title: "Mr",
              mobile: "0726386574",
              landline: "0112563984",
              id_number: Faker::Number.number(13),
              birth_date: Time.now.strftime("%dd/%mm/%YYYY"),
              location: "Riversands Incubation Hub",
              password_confirmation: "sableassets",
              super_admin: true,
              activated: true,status: "Active",
              activated_at: Time.zone.now)

MasterSetup.create!(
  municipality: "Engcobo Local Municipality",
  logo: File.open(File.join(Rails.root,'/app/assets/images','engcobo-logo.jpg')),
  province: "Eastern Cape",
  latitude: -27.9835,
  longitude: 31.6728,
  address: 'Engcobo Local Municipality<br />58 Union Street,<br />ENGCOBO, 5050<br />Eastern Cape, South Africa'
)
#Creating Departments from csv
CSV.foreach('db_engcobo/data/departments.csv', headers: true, :col_sep => ',') do |row|
  Department.create! row.to_hash
end

#Creating Subdepartment from csv
CSV.foreach('db_engcobo/data/subdepartments.csv', headers: true, :col_sep => ',') do |row|
  Subdepartment.create! row.to_hash
end

#directory = File.join(File.dirname(__FILE__), '/migrate/data')
# From lookup_classes
#ActiveRecord::FixtureSet.create_fixtures(File.join(Rails.root, 'db/migrate/data'), 'kpa')
# From lookups
#ActiveRecord::FixtureSet.create_fixtures(File.join(Rails.root, 'db/migrate/data'), 'strategic_objectives')

CSV.foreach('db_engcobo/data/kpa.csv', headers: true, :col_sep => ',') do |row|
  Kpa.create! row.to_hash
end

CSV.foreach('db_engcobo/data/strategic_objectives.csv', headers: true, :col_sep => ',') do |row|
  StrategicObjective.create! row.to_hash
end

CSV.foreach('db_engcobo/data/risk_ratings.csv', headers: true, :col_sep => ',') do |row|
  RiskRating.create! row.to_hash
end

CSV.foreach('db_engcobo/data/kpi_concept.csv', headers: true, :col_sep => ',') do |row|
  KpiConcept.create! row.to_hash
end

CSV.foreach('db_engcobo/data/jobs.csv', headers: true, :col_sep => ',') do |row|
  Jobtitle.create! row.to_hash
end

CSV.foreach('db_engcobo/data/kpi_owners.csv', headers: true, :col_sep => ',') do |row|
  KpiOwner.create! row.to_hash
end

CSV.foreach('db_engcobo/data/kpi_type.csv', headers: true, :col_sep => ',') do |row|
  KpiType.create! row.to_hash
end

CSV.foreach('db_engcobo/data/kpi_calculation_types.csv', headers: true, :col_sep => ',') do |row|
  KpiCalculationType.create! row.to_hash
end

CSV.foreach('db_engcobo/data/ndp_objectives.csv', headers: true, :col_sep => ',') do |row|
  NdpObjective.create! row.to_hash
end

CSV.foreach('db_engcobo/data/predetermined_objectives.csv', headers: true, :col_sep => ',') do |row|
  PredeterminedObjective.create! row.to_hash
end

CSV.foreach('db_engcobo/data/national_outcomes.csv', headers: true, :col_sep => ',') do |row|
  NationalOutcome.create! row.to_hash
end

CSV.foreach('db_engcobo/data/mscore_classification.csv', headers: true, :col_sep => ',') do |row|
  MscoreClassification.create! row.to_hash
end

CSV.foreach('db_engcobo/data/reporting.csv', headers: true, :col_sep => ',') do |row|
  ReportingCategory.create! row.to_hash
end

Ward.create!(name: "All",ward_no: 1,area_id: 1, mun_ref: "Unspecified")
Ward.create!(name: "1",ward_no: 1,area_id: 1, mun_ref:1)
Ward.create!(name: "2",ward_no: 1,area_id: 1, mun_ref:2)
Ward.create!(name: "3",ward_no: 1,area_id: 1, mun_ref:3)
Ward.create!(name: "4",ward_no: 1,area_id: 1, mun_ref:4)
Ward.create!(name: "5",ward_no: 1,area_id: 1, mun_ref:5)
Ward.create!(name: "6",ward_no: 1,area_id: 1, mun_ref:6)
Ward.create!(name: "7",ward_no: 1,area_id: 1, mun_ref:7)
Ward.create!(name: "8",ward_no: 1,area_id: 1, mun_ref:8)
Ward.create!(name: "9",ward_no: 1,area_id: 1, mun_ref:9)
Ward.create!(name: "10",ward_no: 1,area_id: 1, mun_ref:10)
Ward.create!(name: "11",ward_no: 1,area_id: 1, mun_ref:11)
Ward.create!(name: "12",ward_no: 1,area_id: 1, mun_ref:12)
Ward.create!(name: "13",ward_no: 1,area_id: 1, mun_ref:13)
Ward.create!(name: "14",ward_no: 1,area_id: 1, mun_ref:14)
Ward.create!(name: "15",ward_no: 1,area_id: 1, mun_ref:15)
Ward.create!(name: "16",ward_no: 1,area_id: 1, mun_ref:16)
Ward.create!(name: "17",ward_no: 1,area_id: 1, mun_ref:17)
Ward.create!(name: "18",ward_no: 1,area_id: 1, mun_ref:18)
Ward.create!(name: "19",ward_no: 1,area_id: 1, mun_ref:19)

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

CSV.foreach('db_engcobo/data/capital.csv', headers: true, :col_sep => ',') do |row|
  CapitalProject.create! row.to_hash
end

CSV.foreach('db_engcobo/data/mtas_indicators.csv', headers: true, :col_sep => ',') do |row|
  MtasIndicator.create! row.to_hash
end

CSV.foreach('db_engcobo/data/departmental_kpis.csv', headers: true, :col_sep => ',') do |row|
  DepartmentalSdbip.create! row.to_hash
end
