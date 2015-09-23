source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '~>4.0.0'

# Bundle edge Rails instead:
# gem 'rails', git: 'git://github.com/rails/rails.git'

gem 'execjs'

# Locked down to avoid big leap upgrading
gem 'mongoid', '~> 4.0.0'
gem 'bson_ext', '>= 1.5'
gem 'mongoid_rails_migrations', '>= 0.0.13'
gem 'mongoid-tree', '>= 0.7'
# gem 'therubyracer'
gem 'slim'
# gem 'sprockets'
# gem 'railties'
gem 'factory_girl_rails', require: false
gem 'wkhtmltopdf-binary', '>=0.9.9.1'
gem 'wicked_pdf', '>=0.9.6'
gem 'rails_admin', '> 0.4.3'
gem 'devise'
gem 'valid_email'
gem 'redcarpet'
gem "gritter", "1.0.3"
gem "airbrake", ">=3.1.12"
gem "sucker_punch"
gem "protected_attributes"

group :development do
  gem 'mongrel', '~> 1.2.0.pre2'
  gem 'better_errors'
  gem 'meta_request'
end

gem 'sass-rails',   '>= 4.0.0'
gem 'stylus'
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes

gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails', '>=2.1'

group :development, :test do
  gem 'rspec-rails', '>=3.0'
  gem "letter_opener"
  gem 'email_spec'
end

group :test do
  gem 'rspec-collection_matchers'
  gem 'cucumber-rails', '>=1.4.0', require: false
  gem 'capybara', '>=2.5.0'
  gem 'capybara-webkit', '>=1.7.0'
  gem 'capybara-screenshot'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner', '>= 1.0.0'
  gem 'launchy'
  gem 'wait_for'
  gem 'byebug'
  gem 'simplecov', :require => false, :group => :test
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano', require: false
