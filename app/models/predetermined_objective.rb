class PredeterminedObjective < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	has_many :departmental_sdbips
	has_many :top_layer_sdbips
	delegate :name, :to => :departmental_sdbip, :prefix => true
	delegate :name, :to => :top_layer_sdbips, :prefix => true
	validates :name, presence: true
end
