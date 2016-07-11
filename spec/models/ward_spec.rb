require 'rails_helper'
require 'spec_helper'


RSpec.describe Ward, type: :model do
let(:valid_attributes) {
    {
      name: "1"
     }
  }
 
describe 'associations' do
it { should belong_to(:area)}
it { should have_many(:departmental_sdbips)}
it { should have_many(:capital_projects)}

  end

end
