class RevenueBySource < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  include PublicActivity::Common
  validates :vote_number,presence: true
end
