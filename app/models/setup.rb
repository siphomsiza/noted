class Setup < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :departmental_sdbip
end
