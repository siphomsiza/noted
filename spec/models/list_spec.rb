require 'rails_helper'
require 'spec_helper'

RSpec.describe List, type: :model do
  
describe 'associations' do

	it { should have_many(:areas).dependent(:destroy) }
	it { should have_many(:funding_sources).dependent(:destroy) }
	it { should have_many(:kpi_calculation_types).dependent(:destroy) }
	it { should have_many(:kpi_concepts).dependent(:destroy) }
	it { should have_many(:kpi_owners).dependent(:destroy) }
	it { should have_many(:kpi_target_types).dependent(:destroy) }
	it { should have_many(:kpi_types).dependent(:destroy) }
	it { should have_many(:mscore_classifications).dependent(:destroy) }
	it { should have_many(:kpas).dependent(:destroy) }
	it { should have_many(:national_outcomes).dependent(:destroy) }
	it { should have_many(:ndp_objectives).dependent(:destroy) }
	it { should have_many(:predetermined_objectives).dependent(:destroy) }
	it { should have_many(:provincial_strategic_outcomes).dependent(:destroy) }
	it { should have_many(:reporting_categories).dependent(:destroy) }
	it { should have_many(:risk_ratings).dependent(:destroy) }
	it { should have_many(:strategic_objectives).dependent(:destroy) }
	xit { should have_many(:mtas_indicators).dependent(:destroy) }
	

	xit { should accept_nested_attributes_for(:areas) }
	xit { should accept_nested_attributes_for(:funding_sources) }
	xit { should accept_nested_attributes_for(:kpi_calculation_types) }
	xit { should accept_nested_attributes_for(:kpi_concepts) }
	xit { should accept_nested_attributes_for(:kpi_owners) }
	xit { should accept_nested_attributes_for(:kpi_target_types) }
	xit { should accept_nested_attributes_for(:kpi_types) }
	xit { should accept_nested_attributes_for(:mscore_classifications) }
	xit { should accept_nested_attributes_for(:kpas) }
	xit { should accept_nested_attributes_for(:national_outcomes) }
	xit { should accept_nested_attributes_for(:ndp_objectives) }
	xit { should accept_nested_attributes_for(:predetermined_objectives) }
	xit { should accept_nested_attributes_for(:provincial_strategic_outcomes) }
	xit { should accept_nested_attributes_for(:reporting_categories) }
	xit { should accept_nested_attributes_for(:risk_ratings) }
	xit { should accept_nested_attributes_for(:strategic_objectives) }
	xit { should accept_nested_attributes_for(:mtas_indicators) }
	end

let(:collection) {
    {
      

     }
  }
  let(:list) {List.create(collection)}
		before do
      	List.create(collection)
	end

	xit 'expect area form' do
		
	list = List.new(collection)

		expect(collection).to eq(areas.where(list_id: id))

		if (collection.any) != nil
		expect(collection.any).to eq(collection)
	else 
		expect(collection.any).to eq(collection.build)
	end
end
end



























