require 'rails_helper'
require 'spec_helper'

RSpec.describe SetupsHelper, type: :helper do
  describe "options for select" do
    it "returns the options for select" do
      assign(options_for_select).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    end
  end
end
