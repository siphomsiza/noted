require 'spec_helper'
require 'rails_helper'

RSpec.describe FundingSource, type: :model do

describe 'associations' do

	it { should belong_to(:list) }
	
	end
end 
