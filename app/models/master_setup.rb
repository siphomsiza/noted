class MasterSetup < ActiveRecord::Base
  ActiveRecord::Base.establish_connection($current_session_db)
  include PublicActivity::Common
  validates :municipality,:province, :presence=> true, :uniqueness=>true

  def initialize(params = {})
    #logo = params.delete(:logo)
  super
  if logo
    #self.logo_name = sanitize_filename(logo.original_filename)
    #self.logo_content_type = logo.content_type
    #self.logo = logo.read
  end
end
private
  def sanitize_filename(filename)
    return File.basename(filename)
  end
end
