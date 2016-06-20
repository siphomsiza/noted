class SdbipTimePeriod < ActiveRecord::Base
  has_many :departmental_sdbips
  belongs_to :sdbip_report
end
