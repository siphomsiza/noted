class MscoreClassification < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	has_many :departmental_sdbips
	has_many :capital_projects
	has_many :monthly_cashflows
	has_many :top_layer_sdbips
	delegate :name, :to => :top_layer_sdbips, :prefix => true
	delegate :name, :to => :departmental_sdbip, :prefix => true
	delegate :name, :to => :capital_projects, :prefix => true
	delegate :name, :to => :monthly_cashflows, :prefix => true
	validates :name, presence: true
end
