class KpiCalculationType < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	has_many :departmental_sdbips
	has_many :top_layer_sdbips
	delegate :name, :to => :top_layer_sdbips, :prefix => true
	delegate :name,:code, :to => :departmental_sdbip, :prefix => true
	validates :name, presence: true
end
