require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiCalculationType, type: :model do

describe 'associations' do
it { should have_many(:departmental_sdbips) }
it { should have_many(:top_layer_sdbips) }
end
end
