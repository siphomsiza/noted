require 'rails_helper'
require 'spec_helper'
RSpec.describe MasterSetup, type: :model do
  describe 'associations' do
    it { should validate_presence_of(:municipality) }
    it { should validate_presence_of(:province) }

  end
end
