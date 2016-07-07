require 'rails_helper'
require 'spec_helper'

RSpec.describe MonthlyCashflow, type: :model do

describe 'associations' do
	it { should belong_to(:department) } 
	it { should belong_to(:subdepartment)}
	it { should belong_to(:mscore_classification)}
	it {should validate_presence_of(:month)}
	end
end