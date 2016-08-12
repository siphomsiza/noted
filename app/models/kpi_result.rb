class KpiResult < ActiveRecord::Base
  establish_connection($current_session_db)
  belongs_to :user
  belongs_to :departmental_sdbip
  has_one :assurance
  has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true
  def attachment_for_form
      collection = attachments.where(kpi_result_id: id)
      collection.any? ? collection : attachments.build
  end
end
