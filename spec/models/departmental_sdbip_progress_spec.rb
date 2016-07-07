require 'rails_helper'
require 'spec_helper'

RSpec.describe DepartmentalSdbipProgress, type: :model do

describe 'associations' do

	it { should belong_to(:departmental_sdbip)}
	end
end