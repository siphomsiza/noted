require 'rails_helper'
require 'spec_helper'
RSpec.describe ActivityLog, type: :model do
  describe 'validation' do
    it { is_expected.to belong_to(:user) }
  end
end
