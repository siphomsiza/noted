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
	it {should belong_to(:area)}
	it {should belong_to(:kpi_calculation_type)}
	it {should belong_to(:kpi_concept)}
	it {should belong_to(:kpi_type)}
	it {should belong_to(:ndp_objective)}
	it {should belong_to(:provincial_strategic_outcome)}
	it {should belong_to(:reporting_category)}
	it {should belong_to(:risk_rating)}
	it {should belong_to(:strategic_objective)}
	it {should belong_to(:ward)}
	it {should belong_to(:capital_project)}
	it {should have_many(:departmental_sdbip_progresses).dependent(:destroy)}
	it { should accept_nested_attributes_for(:departmental_sdbip_progresses) }

	end 

	it 'return subdepartments where subdepartment_id is equal to its id' do
	end
	
end


