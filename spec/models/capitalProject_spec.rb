require 'rails_helper'
require 'spec_helper'

RSpec.describe CapitalProject, type: :model do
  describe 'validation' do
    it { should belong_to(:departmental_sdbip) }
    it { should belong_to(:subdepartment) }
    it { should belong_to(:mscore_classification) }
    it { should belong_to(:area) }
    it { should belong_to(:ward) }
  end

  it 'import csv file' do
  end

  it 'fetch excel file' do
  end

  it 'opens spreadsheet' do
  end
end
