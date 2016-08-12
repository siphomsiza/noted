class Attachment < ActiveRecord::Base
  establish_connection($current_session_db)
  belongs_to :kpi_result
  mount_uploader :poe, PoeUploader
end
