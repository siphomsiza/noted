require 'rails_helper'
require 'spec_helper'


RSpec.describe Department, type: :model do
let(:valid_attributes) {
    {
      name: "finance department"
     }
  }
 
describe 'associations' do
it { should have_many(:users)}
it { should have_many(:top_layer_sdbips)}
it { should have_many(:monthly_cashflows)}
it { should have_many(:roles_details)}
it { should have_many(:capital_projects)}
it { should have_many(:departmental_sdbips)}
it { should have_many(:subdepartments).dependent(:destroy)}

  end

describe 'validations' do

  let(:department) { Department.new(valid_attributes) }
    before do
        Department.create(valid_attributes)
  end

  
  it { expect(department).to validate_presence_of(:name) }
  it { expect(department).to validate_presence_of(:tel_no)}
  it { expect(department).to validate_presence_of(:fax_no) }
  it { expect(department).to validate_numericality_of(:tel_no) }
  it { expect(department).to validate_numericality_of(:fax_no) }

  xit "requires a unique name (case sensitive)" do
        department.name = "finance department"
        expect(department).to validate_uniqueness_of(:name)
  end


  end
end


