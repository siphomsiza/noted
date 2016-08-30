class Attachment < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  belongs_to :kpi_result
  #mount_uploader :poe, PoeUploader
  has_attached_file :poe#, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :poe, :content_type => ['image/jpeg', 'image/png', 'image/gif','application/pdf']
  delegate :poe_file_name,:poe_content_type, :to => :kpi_result, :prefix => true
end
