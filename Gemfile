source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.21'

# Bundle edge Rails instead:
# gem 'rails', git: 'git://github.com/rails/rails.git'

gem 'execjs', '~> 1.4.0'

# was a git dependency before, locked down only to avoid upgrading a big leap for now
gem 'mongoid', '~> 3.0.23'
gem 'bson_ext', '>= 1.5'
gem 'mongoid_rails_migrations', '>= 0.0.13'
gem 'mongoid-tree', '>= 0.7'
# gem 'therubyracer'
gem 'slim', '~> 1.1.1'
# gem 'sprockets'
# gem 'railties'
gem 'factory_girl_rails'#, '~> 3.0.0', require: false
gem 'wkhtmltopdf-binary', '>=0.9.9.1'
gem 'wicked_pdf', '>=0.9.6'
gem 'rails_admin', '> 0.4.3'
gem 'devise', '~> 2.0.4'
gem 'valid_email', '~> 0.0.4'
gem 'redcarpet', '~> 2.2.2'
gem 'gritter', '1.0.3'
gem 'airbrake', '>=3.1.12'
gem 'sucker_punch', '~> 1.0.2'

group :development do
  gem 'mongrel', '~> 1.2.0.pre2'
  gem 'better_errors', '~> 0.9.0'
  gem 'meta_request', '~> 0.2.7'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '>= 3.2.3'
  gem 'stylus', '~> 0.5.0'
  # locked down to resolve conflicts for bundle update rails_admin
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '2.1'

group :development, :test do
  gem 'rspec-rails', '~> 3.2'
  gem 'letter_opener'#, '~> 1.0.0'
  gem 'email_spec'#, '~> 1.2.1'
end

group :test do
  # gem 'rspec_multi_matchers'#, '~> 1.2.1'
  gem 'cucumber-rails', '~> 1.3.0', require: false
  # restricting until capybara-webkit releases a version compatible with 2.1
  gem 'capybara'#, '~> 2.0.3'
  # gem 'capybara-webkit'#, '~> 0.14.2'
  # gem 'capybara-screenshot'#, '~> 0.3.6'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'#, '>= 1.0.0'
  gem 'launchy'#, '~> 2.1.0'
  gem 'wait_for'#, '~> 0.1.1'
  gem 'debugger'#, '~> 1.6.1'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '~> 2.11.2'
gem 'rvm-capistrano', '~> 1.2.7'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


