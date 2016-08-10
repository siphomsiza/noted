class TopLayerAdministrator < ActiveRecord::Base
  establish_connection($current_session_db)
  include PublicActivity::Common
  belongs_to :user
  belongs_to :department
end
