class KpiResult < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  belongs_to :user
  belongs_to :departmental_sdbip
  has_one :assurance
  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  delegate :period,:target,:corrective_measures,:performance_comments,:kpi_performance_standard,:actual, :to => :departmental_sdbip, :prefix => true
end
