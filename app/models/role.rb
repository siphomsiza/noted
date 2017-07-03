class Role < ActiveRecord::Base
	ActiveRecord::Base.establish_connection(Rails.env.to_sym)
	include PublicActivity::Common
	belongs_to :user
	validates :user_id, presence: true, numericality: true
end
