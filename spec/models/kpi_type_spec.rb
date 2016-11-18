require 'spec_helper'
require 'rails_helper'

RSpec.describe KpiType, type: :model do

describe 'associations' do
it { should have_many(:departmental_sdbips)}

end
end
