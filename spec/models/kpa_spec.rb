require 'spec_helper'
require 'rails_helper'

RSpec.describe Kpa, type: :model do

describe 'association' do
it { should have_many (:departmental_sdbips)}
it { should have_many (:top_layer_sdbips)}
end
end
