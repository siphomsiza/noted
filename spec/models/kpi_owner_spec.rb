require 'rails_helper'
require 'spec_helper'

RSpec.describe KpiOwner, type: :model do

describe 'associations' do
  it { should belong_to(:user)}
it { should have_many(:departmental_sdbips)}
it { should have_many(:top_layer_sdbips)}
end
end
