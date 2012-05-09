desc "Run all tests"

task :test => [:spec, :cucumber]

task :spec do
  next unless Rails.env == 'development'
  p "'rake spec' called from development env, forward it to 'rake RAILS_ENV=test spec'"
  system('rake RAILS_ENV=test spec')
end

namespace :ci do
  task :test => 'rake:test'
end
