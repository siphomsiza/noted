class RevenueBySource < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  include PublicActivity::Common
  validates :vote_number,presence: true
end
