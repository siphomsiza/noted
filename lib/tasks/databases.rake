require 'roo'
require "#{Rails.root}/config/environment"
namespace :mkhondo do
  desc 'Configure the variables that rails need in order to look up for the db configuration in a different folder'

  task :set_custom_db_config_paths do
    ENV['schema.rb'] = 'db/schema.rb'
    Rails.application.config.paths['db'] = ['db_mkhondo']
    Rails.application.config.paths['db/migrate'] = ['db/migrate']
    Rails.application.config.paths['db/seeds.rb'] = ['db_mkhondo/seeds.rb']
    Rails.application.config.paths['config/database'] = ['config/mkhondo_db.yml']
  end

  namespace :db do
    task reset: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:setup'].invoke
    end
    task drop: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
    end
    task create: :set_custom_db_config_paths do
      Rake::Task['db:create'].invoke
    end
    task migrate: :set_custom_db_config_paths do
      Rake::Task['db:migrate'].invoke
    end
    task rollback: :set_custom_db_config_paths do
      Rake::Task['db:rollback'].invoke
    end
    task seed: :set_custom_db_config_paths do
      Rake::Task['db:seed'].invoke
    end
    namespace :test do
      task prepare: :set_custom_db_config_paths do
        Rake::Task['db:test:prepare'].invoke
      end
    end
    task version: :set_custom_db_config_paths do
      Rake::Task['db:version'].invoke
    end
    task :dump do
      Rake::Task['db:schema:dump'].invoke
    end
    namespace :schema do
      task :load do
        Rake::Task['db:schema:load'].invoke
      end
    end
  end
end
namespace :sakhisizwe do
  desc 'Configure the variables that rails need in order to look up for the db configuration in a different folder'
  task :set_custom_db_config_paths do
    ENV['schema.rb'] = 'db/schema.rb'
    Rails.application.config.paths['db'] = ['db_sakhisizwe']
    Rails.application.config.paths['db/migrate'] = ['db/migrate']
    Rails.application.config.paths['db/seeds.rb'] = ['db_sakhisizwe/seeds.rb']
    Rails.application.config.paths['config/database'] = ['config/sakhisizwe_db.yml']
  end

  namespace :db do
    task reset: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:setup'].invoke
    end
    task drop: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
    end
    task create: :set_custom_db_config_paths do
      Rake::Task['db:create'].invoke
    end
    task migrate: :set_custom_db_config_paths do
      Rake::Task['db:migrate'].invoke
    end
    task rollback: :set_custom_db_config_paths do
      Rake::Task['db:rollback'].invoke
    end
    task seed: :set_custom_db_config_paths do
      Rake::Task['db:seed'].invoke
    end
    namespace :test do
      task prepare: :set_custom_db_config_paths do
        Rake::Task['db:test:prepare'].invoke
      end
    end
    task version: :set_custom_db_config_paths do
      Rake::Task['db:version'].invoke
    end
    task :dump do
      Rake::Task['db:schema:dump'].invoke
    end
    namespace :schema do
      task :load do
        Rake::Task['db:schema:load'].invoke
      end
    end
  end
end
namespace :lepelle_nkumpi do
  desc 'Configure the variables that rails need in order to look up for the db configuration in a different folder'

  task :set_custom_db_config_paths do
    ENV['schema.rb'] = 'db_lepelle_nkumpi/schema.rb'
    Rails.application.config.paths['db'] = ['db_lepelle_nkumpi']
    Rails.application.config.paths['db/migrate'] = ['db_lepelle_nkumpi/migrate']
    Rails.application.config.paths['db/seeds.rb'] = ['db_lepelle_nkumpi/seeds.rb']
    Rails.application.config.paths['config/database'] = ['config/lepelle_nkumpi_db.yml']
  end

  namespace :db do
    task reset: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:setup'].invoke
    end
    task drop: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
    end
    task create: :set_custom_db_config_paths do
      Rake::Task['db:create'].invoke
    end
    task migrate: :set_custom_db_config_paths do
      Rake::Task['db:migrate'].invoke
    end
    task rollback: :set_custom_db_config_paths do
      Rake::Task['db:rollback'].invoke
    end
    task seed: :set_custom_db_config_paths do
      Rake::Task['db:seed'].invoke
    end
    namespace :test do
      task prepare: :set_custom_db_config_paths do
        Rake::Task['db:test:prepare'].invoke
      end
    end
    task version: :set_custom_db_config_paths do
      Rake::Task['db:version'].invoke
    end
    task :dump do
      Rake::Task['db:schema:dump'].invoke
    end
    namespace :schema do
      task :load do
        Rake::Task['db:schema:load'].invoke
      end
    end
  end
end
namespace :engcobo do
  desc 'Configure the variables that rails need in order to look up for the db configuration in a different folder'

  task :set_custom_db_config_paths do
    ENV['schema.rb'] = 'db/schema.rb'
    Rails.application.config.paths['db'] = ['db_engcobo']
    Rails.application.config.paths['db/migrate'] = ['db/migrate']
    Rails.application.config.paths['db/seeds.rb'] = ['db_engcobo/seeds.rb']
    Rails.application.config.paths['config/database'] = ['config/engcobo_db.yml']
  end

  namespace :db do
    task reset: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:setup'].invoke
    end
    task drop: :set_custom_db_config_paths do
      Rake::Task['db:drop'].invoke
    end
    task create: :set_custom_db_config_paths do
      Rake::Task['db:create'].invoke
    end
    task migrate: :set_custom_db_config_paths do
      Rake::Task['db:migrate'].invoke
    end
    task rollback: :set_custom_db_config_paths do
      Rake::Task['db:rollback'].invoke
    end
    task seed:  :set_custom_db_config_paths do
      Rake::Task['db:seed'].invoke
    end

    namespace :test do
      task prepare: :set_custom_db_config_paths do
        Rake::Task['db:test:prepare'].invoke
      end
    end
    task version: :set_custom_db_config_paths do
      Rake::Task['db:version'].invoke
    end
    task :dump do
      Rake::Task['db:schema:dump'].invoke
    end
    namespace :schema do
      task :load do
        Rake::Task['db:schema:load'].invoke
      end
    end

    # task db_engcobo_upload: :set_custom_db_config_paths do
    #   Dir[File.join(Rails.root, 'db_engcobo', 'engcobo_uploads', '*.rb')].each do |filename|
    #     load(filename) if File.exist?(filename)
    #   end
    # end

  end
end
db_conf = YAML.load(File.open(File.join(Rails.root, '/config', 'database.yml')))
DB1_CONF = db_conf['db1'][Rails.env]
DB2_CONF = db_conf['db2'][Rails.env]
DB3_CONF = db_conf['db3'][Rails.env]
DB4_CONF = db_conf['db4'][Rails.env]
