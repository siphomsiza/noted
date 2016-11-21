require 'rails_helper'
require 'spec_helper'

RSpec.describe Attachment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:kpi_result) }
  end
end
