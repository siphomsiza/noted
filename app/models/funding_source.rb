class FundingSource < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	validates :name, presence: true
end
