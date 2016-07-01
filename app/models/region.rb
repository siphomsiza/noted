class Region < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :master_setup
  validates :name, :presence=> true, :uniqueness=>true
end
