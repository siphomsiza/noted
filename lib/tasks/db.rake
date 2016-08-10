desc "Migrate the database through scripts in db/migrate directory."
namespace :db do
  task :migrate do
    Rake::Task["db:migrate_db1"].invoke
    Rake::Task["db:migrate_db2"].invoke
  end

  task :drop do
    Rake::Task["db:drop_db1"].invoke
    Rake::Task["db:drop_db2"].invoke
  end

  #task :create do
  #  Rake::Task["db:create_db1"].invoke
  #  Rake::Task["db:create_db2"].invoke
  #end

  #task :seed do
  #  Rake::Task["db:seed_db1"].invoke
  #  Rake::Task["db:seed_db2"].invoke
  #end

  task :drop_db1 do
    Rake::Task["db:drop"].execute
  end

  task :drop_db2 do
    Rake::Task["db:drop"].execute
  end

  task :migrate_db1 do
    ActiveRecord::Base.establish_connection(DB1_CONF)
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  task :migrate_db2 do
    ActiveRecord::Base.establish_connection(DB2_CONF)
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

end
