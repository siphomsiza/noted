class Department < ActiveRecord::Base
	include PublicActivity::Common
	has_many :users
	has_many :roles
	has_many :top_layer_sdbips
	has_many :monthly_cashflows
	has_many :roles_details
	has_many :departmental_sdbips
	has_many :subdepartments, :dependent => :destroy
	accepts_nested_attributes_for :subdepartments, allow_destroy: true
	validates_presence_of :name, :tel_no, :fax_no
	validates_uniqueness_of :name
	validates :name,format: { with: /\A[a-zA-Z',. ]+\z/ }
	validates_numericality_of :tel_no, :fax_no

	def subdepartment_for_form
    collection = subdepartments.where(department_id: id)
    collection.any? ? collection : subdepartments.build
  	end
end
