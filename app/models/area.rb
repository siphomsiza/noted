class Area < ActiveRecord::Base
  establish_connection($current_session_db)
  has_many :wards, :dependent => :destroy
	accepts_nested_attributes_for :wards, allow_destroy: true
	validates_presence_of :name
	validates_uniqueness_of :name
	validates :name,format: { with: /\A[a-zA-Z',. ]+\z/ }

	def ward_for_form
    collection = wards.where(area_id: id)
    collection.any? ? collection : wards.build
  	end
end
