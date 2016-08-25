namespace :deploy do
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
  after "deploy", "deploy:symlink_config_files"
  #after 'deploy:migrate', 'deploy:reset'
end
