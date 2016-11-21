require 'rails_helper'
require 'spec_helper'

RSpec.describe MscoreClassification, type: :model do

describe 'associations' do
it { should have_many(:departmental_sdbips)}
it { should have_many(:capital_projects)}
it { should have_many(:monthly_cashflows)}
end
end
