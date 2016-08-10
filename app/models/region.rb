class Region < ActiveRecord::Base
  establish_connection($current_session_db)
  include PublicActivity::Common
  belongs_to :master_setup
  validates :name, :presence=> true, :uniqueness=>true
end
