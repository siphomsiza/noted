require 'rails_helper'
require 'spec_helper'

RSpec.describe NdpObjective, type: :model do

describe 'validations' do

	it { should belong_to(:list) }
	it { should have_many(:departmental_sdbips) }
	xit { should have_one(:top_layer_sdbip) }
	end 
end