require 'rails_helper'
require 'spec_helper'

RSpec.describe ProvincialStrategicOutcome, type: :model do

describe 'validations' do

	it { should belong_to(:list) }
	it { should have_many(:departmental_sdbips) }
	end
end