# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
if Rails.env.production?
  db_conf = YAML::load(File.open(File.join(Rails.root,'/shared/config','database.yml')))
  DB1_CONF = db_conf["db1"][Rails.env]
  DB2_CONF = db_conf["db2"][Rails.env]
else !Rails.env.production?
  db_conf = YAML::load(File.open(File.join(Rails.root,'/config','database.yml')))
  DB1_CONF = db_conf["db1"][Rails.env]
  DB2_CONF = db_conf["db2"][Rails.env]
end
