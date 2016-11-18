require 'rails_helper'
require 'spec_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "returns the full title" do
      assign(:base_title,"KEYSTONE App")
      assign(:page_title,"")
      helper.full_title.should eql("KEYSTONE App")
    end
  end
  describe "#active_class" do

  end
  describe "#link_to_add_fields" do

  end
  describe "#viewable_by" do

  end
end
