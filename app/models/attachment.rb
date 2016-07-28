class Attachment < ActiveRecord::Base
  belongs_to :kpi_result
  mount_uploader :poe, PoeUploader
end
