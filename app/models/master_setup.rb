class MasterSetup < ActiveRecord::Base
  has_many :regions, :dependent => :destroy
  accepts_nested_attributes_for :regions, allow_destroy: true
  def regions_for_form
    collection = regions.where(municipality_id: id)
    collection.any? ? collection : regions.build
  end
end
