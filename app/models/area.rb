class Area < ActiveRecord::Base
	belongs_to :list
	has_many :departmental_sdbip
	has_many :capital_projects
	has_many :wards, :dependent => :destroy
	accepts_nested_attributes_for :wards, allow_destroy: true
	def ward_for_form
    	collection = wards.where(area_id: id)
    	collection.any? ? collection : wards.build
  end
end
