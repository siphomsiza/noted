class Jobtitle < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  include PublicActivity::Common
  validates :title, :presence=> true, :uniqueness=>true
end
