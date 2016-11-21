require 'rails_helper'
require 'spec_helper'
RSpec.describe Subdepartment, type: :model do
let(:valid_attributes) {
    {
      name: "finance subdepartment"
  }
 }

describe 'associations' do
  it { should have_many(:subdepartmental_administrators) }
  it { should have_many(:departmental_sdbips) }
  it { should have_many(:capital_projects) }
  it { should have_many(:monthly_cashflows) }
  it { should belong_to(:department) }
  end

describe 'validations' do

  let(:subdepartment) { Subdepartment.new(valid_attributes) }
    before do
        Subdepartment.create(valid_attributes)
  end

  it { expect(subdepartment).to validate_presence_of(:name) }
  it { expect(subdepartment).to validate_uniqueness_of(:name) }
  end
end
