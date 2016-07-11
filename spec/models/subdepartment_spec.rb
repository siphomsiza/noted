
require 'rails_helper'
require 'spec_helper'


RSpec.describe Subdepartment, type: :model do
let(:valid_attributes) {
    {
      subdepartment_name: "finance subdepartment"
  }
 }
describe 'associations' do
xit { should have_many(:users)}
xit { should have_many(:roles)}
it { should have_many(:roles_details)}
it { should have_many(:departmental_sdbips)}
it { should have_many(:capital_projects)}
it { should have_many(:monthly_cashflows)}
it { should belong_to(:department)}

  end

describe 'validations' do

  let(:subdepartment) { Subdepartment.new(valid_attributes) }
    before do
        Subdepartment.create(valid_attributes)
  end

  
  it { expect(subdepartment).to validate_presence_of(:subdepartment_name) }
  it { expect(subdepartment).to validate_uniqueness_of(:subdepartment_name) }
end

end



