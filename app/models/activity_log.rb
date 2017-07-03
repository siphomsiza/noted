class ActivityLog < ActiveRecord::Base
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  belongs_to :user
end
