
namespace :db do
  task :seed => :environment do
    env_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")
    load(env_seed_file) if File.exist?(env_seed_file)
  end
end

namespace :spec do
  next unless Rails.env == 'development'
  p "'rake spec' called from development env, forward it to 'rake RAILS_ENV=test spec'"
  exec('rake RAILS_ENV=test spec')
end
