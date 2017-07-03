class ReportingCategory < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	has_many :departmental_sdbips
	delegate :name, :to => :departmental_sdbip, :prefix => true
	validates :name, presence: true
end
