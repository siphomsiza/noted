class Assurance < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  belongs_to :user
  belongs_to :departmental_sdbip
  belongs_to :kpi_result
  delegate :signed_off,:response, :to => :departmental_sdbip, :prefix => true
  delegate :signed_off,:response, :to => :kpi_result, :prefix => true
  delegate :signed_off,:response, :to => :user, :prefix => true
end
