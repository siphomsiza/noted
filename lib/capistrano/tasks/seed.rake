namespace :deploy do
  desc 'Load the seed data from db/seeds.rb'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  after 'deploy:reset', 'deploy:seed'
end
