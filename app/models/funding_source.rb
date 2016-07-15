class FundingSource < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :list
	
end
