task :spec do
  next unless Rails.env == 'development'
  p "'rake spec' called from development env, forward it to 'rake RAILS_ENV=test spec'"
  exec('rake RAILS_ENV=test spec')
end
