class Kpa < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	has_many :departmental_sdbips
	has_many :top_layer_sdbips
	validates_presence_of :name, :code
	delegate :name, :to => :top_layer_sdbips, :prefix => true
	delegate :name, :to => :departmental_sdbip, :prefix => true
end
