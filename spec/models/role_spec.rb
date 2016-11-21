require 'rails_helper'
require 'spec_helper'


RSpec.describe Role, type: :model do
let(:valid_attributes) {
    {
      user_id: "1"
  }
 }
describe 'associations' do
  it { should belong_to(:user) }
  end
describe 'validations' do

  let(:role) { Role.new(valid_attributes) }
    before do
        Role.create(valid_attributes)
  end
  it { expect(role).to validate_presence_of(:user_id) }
  it { expect(role).to validate_numericality_of(:user_id) }
  end

end
