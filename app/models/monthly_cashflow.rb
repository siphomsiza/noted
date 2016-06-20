class MonthlyCashflow < ActiveRecord::Base
  belongs_to :department
  belongs_to :subdepartment
  belongs_to :mscore_classification
  validates :month, presence: true
end
