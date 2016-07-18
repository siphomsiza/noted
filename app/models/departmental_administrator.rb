class DepartmentalAdministrator < ActiveRecord::Base
  belongs_to :department
  belongs_to :user
end
