class TopLayerAdministrator < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user
  belongs_to :department
end
