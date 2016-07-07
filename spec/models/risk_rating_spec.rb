require 'rails_helper'
require 'spec_helper'


RSpec.describe RiskRating, type: :model do
let(:valid_attributes) {
    {
      name: "ruby"
  }
 }
describe 'associations' do
it { should belong_to(:list)}
it { should have_many(:departmental_sdbips)}


  end
end