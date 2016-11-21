require 'rails_helper'
require 'spec_helper'

RSpec.describe DepartmentalSdbip, type: :model do

describe 'association' do

it {should belong_to(:department)}
it {should belong_to(:subdepartment)}
it {should belong_to(:kpi_owner)}
it {should belong_to(:predetermined_objective)}
it {should belong_to(:mscore_classification)}
it {should belong_to(:national_outcome)}
it {should belong_to(:strategic_objective)}
it {should belong_to(:kpa)}
it {should belong_to(:kpi_calculation_type)}
it {should belong_to(:kpi_concept)}
it {should belong_to(:kpi_type)}
it {should belong_to(:ndp_objective)}
it {should belong_to(:provincial_strategic_outcome)}
it {should belong_to(:reporting_category)}
it {should belong_to(:risk_rating)}
it {should belong_to(:strategic_objective)}
it {should have_one(:capital_project)}

end

it 'return subdepartments where subdepartment_id is equal to its id' do
end

it 'import csv file' do
end

it 'fetch excel file' do
end

it 'opens spreadsheet' do
end

it 'report to cvs' do
end

it 'to csv' do
end

it 'it searches subdepartment_id,kpi_type_id,start_date,end_date' do
end

it 'search kpi' do
end

it 'search departmental kpi' do
end

it 'search subdepartment kpis' do
end

it ' extent white list' do
end
end
