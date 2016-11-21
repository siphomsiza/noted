require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiResult, type: :model do

describe 'associations' do

it { is_expected.to belong_to(:user) }
it { is_expected.to belong_to(:departmental_sdbip) }
it { is_expected.to have_one(:assurance) }
it { is_expected.to have_many(:attachments).dependent(:destroy) }
end
end
