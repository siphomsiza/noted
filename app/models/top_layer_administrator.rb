class TopLayerAdministrator < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  include PublicActivity::Common
  belongs_to :user
  belongs_to :department
  validates :user_id,:department_id, presence: true
end
