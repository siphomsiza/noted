require 'rails_helper'
require 'spec_helper'

RSpec.describe SubdepartmentalAdministrator, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:subdepartment) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:user_id) }
  end
end
