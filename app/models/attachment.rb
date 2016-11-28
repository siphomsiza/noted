class Attachment < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  belongs_to :kpi_result
  has_attached_file :poe, path: "#{Rails.root}/#{$poe_destination_path}/data/POE/:class/:id/:filename", url: "#{Rails.root}/#{$poe_destination_path}/data/POE/:class/:id/:basename.;extension"
  validates_attachment_content_type :poe, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf', 'application/doc', 'application/docx', 'application/csv']
  delegate :poe_file_name, :poe_content_type, to: :kpi_result, prefix: true
end
