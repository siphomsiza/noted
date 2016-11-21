class Subdepartment < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	has_many :subdepartmental_administrators
	belongs_to :department
	has_many :departmental_sdbips
	has_many :capital_projects
	has_many :monthly_cashflows
	delegate :name, :to => :departmental_sdbip, :prefix => true
	delegate :name, :to => :subdepartmental_administrators, :prefix => true
	delegate :name, :to => :roles, :prefix => true
	delegate :name, :to => :capital_projects, :prefix => true
	delegate :name, :to => :monthly_cashflows, :prefix => true
	delegate :name, :to => :top_layer_sdbips, :prefix => true
	validates_presence_of :name
	validates_uniqueness_of :name

end
