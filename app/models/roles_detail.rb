class RolesDetail < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :role
	belongs_to :department
	belongs_to :subdepartment
	#serialize :department_id,:subdepartment_id,Array
	#validates_presence_of :department_id,:subdepartment_id

end
