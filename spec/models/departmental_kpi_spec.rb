require 'rails_helper'
require 'spec_helper'

RSpec.describe DepartmentalKpi, type: :model do

describe 'association' do

it { is_expected.to belong_to(:department) }
it { is_expected.to belong_to(:subdepartment) }
it { is_expected.to belong_to(:kpi_owner) }
it { is_expected.to belong_to(:predetermined_objective) }
it { is_expected.to belong_to(:mscore_classification) }
it { is_expected.to belong_to(:national_outcome) }
it { is_expected.to belong_to(:strategic_objective) }
it { is_expected.to belong_to(:kpa) }
it { is_expected.to belong_to(:kpi_calculation_type) }
it { is_expected.to belong_to(:kpi_concept) }
it { is_expected.to belong_to(:kpi_target_type) }
it { is_expected.to belong_to(:kpi_type) }
it { is_expected.to belong_to(:mtas_indicator) }
it { is_expected.to belong_to(:ndp_objective) }
it { is_expected.to belong_to(:provincial_strategic_outcome) }
it { is_expected.to belong_to(:reporting_category) }
it { is_expected.to belong_to(:risk_rating) }
it { is_expected.to belong_to(:strategic_objective) }
end
end
