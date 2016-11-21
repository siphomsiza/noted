require 'rails_helper'
require 'spec_helper'

RSpec.describe Jobtitle, type: :model do

describe 'associations' do
it { should validate_presence_of(:title) }
it { should validate_uniqueness_of(:title)}
end
end
