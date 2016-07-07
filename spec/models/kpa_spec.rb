require 'spec_helper'
require 'rails_helper'

RSpec.describe Kpa, type: :model do

describe 'association' do
	
	it { should belong_to(:list) }
	it { should have_many (:departmental_sdbips)}
	end 
end