require 'rails_helper'
require 'spec_helper'


RSpec.describe Role, type: :model do
let(:valid_attributes) {
    {
      user_id: "sungu01"
  }
 }
describe 'associations' do
it { should belong_to(:user)}
xit { should belong_to(:subdepartment)}
it { should have_many(:roles_details).dependent(:destroy) }


  end
describe 'validations' do

  let(:role) { Role.new(valid_attributes) }
    before do
        Role.create(valid_attributes)
  end

  
  it { expect(role).to validate_presence_of(:user_id) }
  it { expect(role).to validate_numericality_of(:user_id) }
  xit { expect(role).to accept_nested_attributes_for(:roles_detail)}
  end

end

