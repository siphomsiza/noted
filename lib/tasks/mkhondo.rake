namespace :mkhondo do
  desc 'Background processing of data to database'
  namespace :jobs do
    task work: :environment do
    Rake::Task['jobs:work'].invoke
    worker = Delayed::Worker.new
    worker.name = 'worker-' + n.to_s
    worker.start
  end
  end
end
