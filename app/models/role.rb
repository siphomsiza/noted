class Role < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	belongs_to :user
	belongs_to :department
	belongs_to :subdepartment
	has_many :roles_details,:dependent => :destroy
	accepts_nested_attributes_for :roles_details, allow_destroy: true
	validates :user_id, presence: true, numericality: true
	#serialize :department_id,:subdepartment_id
	def role_details_for_form
    collection = roles_details.where(role_id: id)
    collection.any? ? collection : roles_details.build
  	end

end
