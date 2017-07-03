class DepartmentalAdministrator < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  belongs_to :department
  belongs_to :user
  validates_presence_of :user_id
end
