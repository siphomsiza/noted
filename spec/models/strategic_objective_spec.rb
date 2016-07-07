require 'rails_helper'
require 'spec_helper'


RSpec.describe StrategicObjective, type: :model do
let(:valid_attributes) {
    {
      name: "objective"
  }
 }
describe 'associations' do

it { should have_many(:departmental_sdbips)}
it { should belong_to(:list)}

  end
end