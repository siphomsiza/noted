require 'rails_helper'
require 'spec_helper'


RSpec.describe StrategicObjective, type: :model do

describe 'associations' do
it { should have_many(:departmental_sdbips)}
  end
end
