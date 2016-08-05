class Subdepartment < ActiveRecord::Base
	include PublicActivity::Common
	has_many :users
	has_many :roles
	has_many :subdepartmental_administrators
	has_many :roles_details
	belongs_to :department
	has_many :departmental_sdbips
	has_many :capital_projects
	has_many :monthly_cashflows

	validates_presence_of :subdepartment_name
	validates_uniqueness_of :subdepartment_name

end
