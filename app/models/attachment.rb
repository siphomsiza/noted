class Attachment < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  belongs_to :kpi_result
  has_attached_file :poe,:path => "db_mkhondo/data/POE/:class/:id/:filename",:url => "/db_mkhondo/data/POE/:class/:id/:basename.;extension"#, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :poe, :content_type => ['image/jpeg', 'image/png', 'image/gif','application/pdf','application/doc','application/docx','application/csv']
  delegate :poe_file_name,:poe_content_type, :to => :kpi_result, :prefix => true
end
