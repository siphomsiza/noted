require 'rails_helper'
require 'spec_helper'

RSpec.describe MasterSetup, type: :model do

describe 'associations' do

	it { should have_many(:regions).dependent(:destroy)}
	it { should accept_nested_attributes_for(:regions)}
	end
end