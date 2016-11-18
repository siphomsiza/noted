require 'rails_helper'
require 'spec_helper'

RSpec.describe MtasIndicator, type: :model do

describe 'associations' do
it{should have_many(:top_layer_sdbips)}
end
end
