source 'https://rubygems.org'
ruby '2.0.0'

# The main web framework
gem 'rails', '~>4.2.0'

# The data store for the app is MongoDB
# mongoid is an object relational mapper on top
# Locked down to avoid big leap upgrading
gem 'mongoid', '~> 4.0.0'
# bson_ext is a native code implementation of bson
# to speed up mongodb operations
gem 'bson_ext', '>= 1.5'
gem 'mongoid_rails_migrations', '>= 0.0.13'
# This provides hierarchy support of our models.
# It's used for the organization hierarchy.
gem 'mongoid-tree', '>= 0.7'
# slim is the template languaged used to implement the views
gem 'slim'
# Factory Girl provides the fixtures for the test suite
gem 'factory_girl_rails', require: false
# Convert html to pdf. Used to provide printable output.
gem 'wicked_pdf', '>=0.9.6'
# The linux binaries for wicked_pdf to use
gem 'wkhtmltopdf-binary', '>=0.9.9.1'
# /admin interface
gem 'rails_admin', '> 0.4.3'
# authentication support for rails_admin
gem 'devise'
gem 'valid_email'
# Markdown template engine
gem 'redcarpet'
# Used to provide javascript based notifications
gem "gritter", ">=1.2.0"
# Automatically reports exceptions to a Saas service.
gem "airbrake", ">=3.1.12"
# Run jobs in the background. Uses threads in the web server process.
gem "sucker_punch"
# Backwards compability with old rails approach before the app
# is migrated to strong_parameters
gem "protected_attributes"
# For running on heroku
gem "thin", group: :heroku
gem "rails_12factor", group: :heroku

group :development do
  gem 'better_errors', platforms: [:mri_20]
  gem 'meta_request'
end

# Currently unused. Can be used to run on css_compressor.
gem 'sass-rails',   '>= 4.0.0'
# the .styl markup language for stylesheet
gem 'stylus'
# We use coffeescript instead of javascript directly
gem 'coffee-rails', '~> 4.0.0'

# Javascript is compressed with this
gem 'uglifier', '>= 1.0.3'

# Bring jquery through the asset pipeline
gem 'jquery-rails', '>=2.1'

group :development, :test do
  # Unit testing framework
  gem 'rspec-rails', '>=3.0'
  # Deliveries emails in development to the browser
  gem "letter_opener"
  # rspec and cucumber support for emails
  gem 'email_spec'
end

group :test do
  gem 'rspec-collection_matchers'
  # Acceptance testing framework
  gem 'cucumber-rails', '>=1.4.0', require: false
  # Capybara provides a DSL for browser automation
  gem 'capybara', '>=2.5.0'
  # Backend for capybara
  gem 'capybara-webkit', '>=1.7.0'
  gem 'capybara-screenshot'
  # Resets state between tests
  gem 'database_cleaner', '>= 1.0.0'
  # debugger
  gem 'byebug', platforms: [:mri_20]
  # Code coverage
  gem 'simplecov', :require => false, :group => :test
end

# Deploy with Capistrano
# the net-ssh dependency on latests version only works with MRI >= 2.0
gem 'capistrano', '~> 2.0', require: false, platforms: [:mri_20]
# RVM (Ruby Version Manager) is used to control the ruby version in production
gem 'rvm-capistrano', require: false, platforms: [:mri_20]
