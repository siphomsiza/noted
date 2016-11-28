class KpiTargetType < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	has_many :top_layer_sdbips
	has_many :departmental_sdbips
	delegate :name, :to => :top_layer_sdbips, :prefix => true
	delegate :name, :to => :departmental_sdbips, :prefix => true
	validates :name, presence: true
end
