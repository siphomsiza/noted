require 'rails_helper'
require 'spec_helper'


RSpec.describe CapitalProject, type: :model do

describe 'validation' do
	it { should belong_to(:department) }
	it { should belong_to(:subdepartment) }
	it { should belong_to(:mscore_classification) }
	it { should belong_to(:area) }
	it { should belong_to(:ward) }

	end

	it "imports .csv or .xls or .xlsx or .ods file" do
	end

	it "it fetches excel data files" do
	end

	it "opens a spreadsheet file" do
	end

end