class MtasIndicator < ActiveRecord::Base
	belongs_to :list
	has_many :departmental_sdbips
end
