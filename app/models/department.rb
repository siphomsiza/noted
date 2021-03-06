class Department < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	has_many :users
	has_many :departmental_administrators
	has_many :top_layer_administrators
	has_many :roles
	has_many :top_layer_sdbips
	has_many :monthly_cashflows
	has_many :roles_details
	has_many :departmental_sdbips
	has_many :subdepartments, :dependent => :destroy
	accepts_nested_attributes_for :subdepartments, allow_destroy: true
	validates_presence_of :name, :tel_no, :fax_no
	validates_uniqueness_of :name
	validates :name,presence: true#format: { with: /\A[a-zA-Z',. ]+\z/ }
	#validates_numericality_of :tel_no, :fax_no
	delegate :name, :to => :departmental_sdbip, :prefix => true
	delegate :name, :to => :roles, :prefix => true
	delegate :name, :to => :monthly_cashflows, :prefix => true
	delegate :name, :to => :top_layer_sdbips, :prefix => true
end
