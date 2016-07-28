class MonthlyCashflow < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :department
  belongs_to :capital_project
  belongs_to :subdepartment
  belongs_to :mscore_classification
  validates :month, presence: true
end
