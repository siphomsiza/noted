require 'rails_helper'
require 'spec_helper'


RSpec.describe RolesDetail, type: :model do
let(:valid_attributes) {
    {
      role_id: "admin"
     }
  }
 
describe 'associations' do

it { should belong_to(:role)}
it { should belong_to(:department)}
it { should belong_to(:subdepartment)}


  end
end

