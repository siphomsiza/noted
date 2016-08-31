class MtasIndicator < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	has_many :top_layer_sdbips
	delegate :name, :to => :top_layer_sdbips, :prefix => true
end
