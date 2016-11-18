require 'rails_helper'
require 'spec_helper'

RSpec.describe Area, type: :model do

describe 'validations' do
it { should have_many(:capital_projects) }
it { should have_many(:wards).dependent(:destroy) }
it { should accept_nested_attributes_for(:wards) }
end

it 'return wards where area_id is equal to its id' do
end
end
