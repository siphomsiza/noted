class Heading < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  include PublicActivity::Common
  validates_presence_of :term
end
