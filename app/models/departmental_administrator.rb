class DepartmentalAdministrator < ActiveRecord::Base
  belongs_to :department
  belongs_to :user
  validates_presence_of :user_id
end
