class Assurance < ActiveRecord::Base
  establish_connection($current_session_db)
  belongs_to :user
  belongs_to :departmental_sdbip
  belongs_to :kpi_result
end
