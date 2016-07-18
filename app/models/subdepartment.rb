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
	#has_one :kpi_owner,:dependent => :destroy
	#accepts_nested_attributes_for :kpi_owners, allow_destroy: true
	validates_presence_of :subdepartment_name
	validates_uniqueness_of :subdepartment_name


	def kpiowners_for_form
    collection = kpiowners.where(department_id: id)
    collection.any? ? collection : kpiowners.build
  	end
end
