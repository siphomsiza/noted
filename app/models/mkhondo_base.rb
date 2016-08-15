class MkhondoBase < ActiveRecord::Base
  def mkhondo_db_connection(model_name)
    db_connection(model_name)
  end
  private
  db_connection(model_name)
    self.abstract_class = true
    databases = YAML::load(IO.read('config/mkhondo_db.yml'))
    model_name.establish_connection(databases[Rails.env])
  end
end
