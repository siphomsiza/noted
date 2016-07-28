class Jobtitle < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user
  validates :title, :presence=> true, :uniqueness=>true
end
