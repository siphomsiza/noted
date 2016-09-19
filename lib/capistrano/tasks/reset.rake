namespace :deploy do
  desc "Symlink shared configs on each release."
  task :symlink_config_files do
      put File.read("#{current_path}/config/mkhondo_db.yml"), "#{shared_path}/config/mkhondo_db.yml"
      put File.read("#{current_path}/config/sakhisizwe_db.yml"), "#{shared_path}/config/sakhisizwe_db.yml"
      #run "ln -nfs #{shared_path}/config/mkhondo_db.yml #{current_path}/config/mkhondo_db.yml"
      #run "ln -nfs #{shared_path}/config/sakhisizwe_db.yml #{current_path}/config/sakhisizwe_db.yml"
    end
  desc 'Resets the database to an empty state'
  task :reset => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:reset"
          execute :rake, "mkhondo:db:reset"
          execute :rake, "sakhisizwe:db:reset"
        end
      end
    end
  end
  after "deploy:migrate", "deploy:reset"
  before "deploy:reset", "deploy:symlink_config_files"
end
