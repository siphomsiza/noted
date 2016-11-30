class MonthlyCashflow < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  include PublicActivity::Common
  belongs_to :department
  belongs_to :capital_project
  belongs_to :subdepartment
  belongs_to :mscore_classification
  validates :month,:department_id, presence: true
end
