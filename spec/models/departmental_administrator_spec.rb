require 'rails_helper'
require 'spec_helper'

RSpec.describe DepartmentalAdministrator, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:user_id) }
  end
end
