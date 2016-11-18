require 'rails_helper'
require 'spec_helper'

RSpec.describe KpiConcept, type: :model do

describe 'associations' do
it { should have_many(:departmental_sdbips)}
end
end
