class Jobtitle < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  include PublicActivity::Common
  belongs_to :user
  validates :title, :presence=> true, :uniqueness=>true
end
