require 'rails_helper'
require 'spec_helper'

RSpec.describe Department, type: :model do
  let(:valid_attributes) {
    {
      name: "Financial Services"
     }
  }

  describe 'associations' do
    it {
      should have_many(:users)
    }

    it {
      should have_many(:top_layer_sdbips)
    }

    it {
      should have_many(:monthly_cashflows)
    }

    it {
      should have_many(:departmental_sdbips)
    }

    it {
      should have_many(:subdepartments).dependent(:destroy)
    }
    it {
      should have_many(:top_layer_administrators)
    }
    it {
      should have_many(:departmental_administrators)
    }
  end

  describe 'validations' do
    #let(:department) {
    #  Department.new()
    #}

    #before do
    #  Department.create(name: "Technical Services")
    #end

    subject { FactoryGirl.build(:department) }

    it {
      is_expected.to validate_presence_of(:name)
    }

    it {
      is_expected.to validate_presence_of(:tel_no)
    }

    it {
      is_expected.to validate_presence_of(:fax_no)
    }

    it {
      is_expected.to validate_numericality_of(:tel_no)
    }

    it {
      is_expected.to validate_numericality_of(:fax_no)
    }

    it {
      is_expected.to validate_uniqueness_of(:name)
    }
  end
end
