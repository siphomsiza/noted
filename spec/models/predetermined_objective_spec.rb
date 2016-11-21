require 'rails_helper'
require 'spec_helper'

RSpec.describe PredeterminedObjective, type: :model do

describe 'validations' do
it { should have_many(:departmental_sdbips) }
end
end
