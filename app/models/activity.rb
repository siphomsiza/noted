class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :departmental_sdbip
  validates :user_id, presence: true
  validates :departmental_sdbip_id, presence: true
end
