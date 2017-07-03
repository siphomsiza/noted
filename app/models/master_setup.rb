class MasterSetup < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  include PublicActivity::Common
  has_attached_file :logo, styles: { medium: '300x300>', small: '140x140', thumb: '60x60' } # , :default_url => "/images/avatars/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  validates :municipality, :province, presence: true
  private
end
