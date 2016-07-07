require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiCalculationType, type: :model do


describe 'associations' do

	it { should belong_to(:list) }
	it { should have_many(:departmental_sdbips) }
	xit { should belong_to(:top_layer_sdbips) }


	end
end