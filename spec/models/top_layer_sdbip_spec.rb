require 'spec_helper'
require 'rails_helper'

RSpec.describe TopLayerSdbip, type: :model do

describe 'association' do
it { should belong_to(:department) }
it { should belong_to(:mscore_classification) }
it { should belong_to(:national_outcome) }
it { should belong_to(:kpi_target_type) }
it { should belong_to(:kpa) }
it { should belong_to(:predetermined_objective) }
it { should belong_to(:strategic_objective) }
it { should belong_to(:strategic_objective) }
it { should belong_to(:ndp_objective) }
it { should belong_to(:ward) }
it { should belong_to(:area) }
it { should belong_to(:kpi_owner) }
it { should belong_to(:mtas_indicator)}
it { should belong_to(:kpi_calculation_type)}

end
end



