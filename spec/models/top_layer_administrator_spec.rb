require 'rails_helper'
require 'spec_helper'

RSpec.describe TopLayerAdministrator, type: :model do

describe 'associations' do
it { is_expected.to belong_to(:user) }
it { is_expected.to belong_to(:department) }
end
end