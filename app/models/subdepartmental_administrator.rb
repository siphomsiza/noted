class SubdepartmentalAdministrator < ActiveRecord::Base
  belongs_to :subdepartment
  belongs_to :user
end
