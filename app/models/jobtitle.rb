class Jobtitle < ActiveRecord::Base
  include PublicActivity::Common
  validates :title, :presence=> true, :uniqueness=>true
end
