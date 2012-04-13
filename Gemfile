source 'https://rubygems.org'

gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails', git: 'git://github.com/rails/rails.git'

gem 'mongoid', git: 'git://github.com/mongoid/mongoid'
gem 'bson_ext', '>= 1.5'
gem 'mongoid_rails_migrations', '>= 0.0.13'
gem 'mongoid-tree', git: 'git://github.com/benedikt/mongoid-tree', branch: 'mongoid-3.0', require: 'mongoid/tree'
# gem 'therubyracer'
gem 'slim'
# gem 'sprockets'
# gem 'railties'
gem 'factory_girl_rails', require: false
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'

group :development do
  gem 'mongrel', '~> 1.2.0.pre2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '>= 3.2.3'
  gem 'stylus'
  gem 'coffee-rails', '>= 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes

  gem 'uglifier', '>= 1.0.3'
end

# gem 'jquery-rails'

group :test do
  gem 'rspec-rails', '>= 2.6'
  gem 'rspec_multi_matchers'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'launchy'
  gem 'wait_for'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
