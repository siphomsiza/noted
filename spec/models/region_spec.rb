require 'rails_helper'
require 'spec_helper'

RSpec.describe Region, type: :model do

describe 'validations' do

	it {should belong_to(:master_setup)}
	end
end