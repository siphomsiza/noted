class TopLayerAdministrator < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  include PublicActivity::Common
  belongs_to :user
  belongs_to :department
  validates :user_id,:department_id, presence: true
end
