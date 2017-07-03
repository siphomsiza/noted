class Area < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  has_many :capital_projects
  has_many :top_layer_sdbips
  has_many :wards, :dependent => :destroy
	accepts_nested_attributes_for :wards, allow_destroy: true
	validates_presence_of :name
	validates_uniqueness_of :name
	validates :name,format: { with: /\A[a-zA-Z0-9',. ]+\z/ }
  delegate :name, :to => :departmental_sdbips, :prefix => true
  delegate :name, :to => :capital_projects, :prefix => true
  delegate :name, :to => :top_layer_sdbips, :prefix => true
end
