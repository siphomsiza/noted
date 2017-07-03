class Ward < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	belongs_to :area
	has_many :top_layer_sdbips
	has_many :capital_projects
	delegate :name, :to => :departmental_sdbips, :prefix => true
	delegate :name, :to => :capital_projects, :prefix => true
	delegate :name, :to => :top_layer_sdbips, :prefix => true
end
