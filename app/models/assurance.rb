class Assurance < ActiveRecord::Base
  belongs_to :user
  belongs_to :departmental_sdbip
  belongs_to :kpi_result
end
