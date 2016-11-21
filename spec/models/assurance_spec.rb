require 'rails_helper'
require 'spec_helper'

RSpec.describe Assurance, type: :model do

describe 'associations' do

it { is_expected.to belong_to(:user)}
it { is_expected.to belong_to(:departmental_sdbip)}
it { is_expected.to belong_to(:kpi_result)}

  end
end