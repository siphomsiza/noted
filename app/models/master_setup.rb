class MasterSetup < ActiveRecord::Base
  establish_connection($current_session_db)
  include PublicActivity::Common
  validates :municipality,:province, :presence=> true, :uniqueness=>true
  has_many :regions, :dependent => :destroy
  accepts_nested_attributes_for :regions, allow_destroy: true
  def regions_for_form
    collection = regions.where(municipality_id: id)
    collection.any? ? collection : regions.build
  end
end
