class Region < ActiveRecord::Base
  belongs_to :master_setup
  validates :name, :presence=> true, :uniqueness=>true
end
