require 'rails_helper'
require 'spec_helper'

RSpec.describe NdpObjective, type: :model do

describe 'validations' do
it { should have_many(:departmental_sdbips) }
it { should have_many(:top_layer_sdbips) }
end
end
