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
# This provides hierarchy support of our models.
# It's used for the organization hierarchy.
gem 'mongoid-tree', '>= 0.7'
# slim is the template languaged used to implement the views
gem 'slim'
# Factory Girl provides the fixtures for the test suite
gem 'factory_girl_rails', require: false
# Convert html to pdf. Used to provide printable output.
gem 'wicked_pdf', '~>0.11.0'
# /admin interface
gem 'rails_admin', '> 0.4.3'
# authentication support for rails_admin
gem 'devise'
gem 'valid_email'
# Markdown template engine
gem 'redcarpet'
# Used to provide javascript based notifications
gem "gritter", ">=1.2.0"
# Run jobs in the background. Uses threads in the web server process.
gem "sucker_punch", "~>1.5.0"

group :development do
  gem 'better_errors', platforms: [:mri_20]
  gem 'meta_request'
end

# the .styl markup language for stylesheet
gem 'stylus'
# We use coffeescript instead of javascript directly
gem 'coffee-rails', '~> 4.1.0'

# Javascript is compressed with this
gem 'uglifier', '>= 1.0.3'

# Bring jquery through the asset pipeline
gem 'jquery-rails', '>=2.1'

group :development, :test do
  # Unit testing framework
  gem 'rspec-rails', '>=3.0'
  # rspec and cucumber support for emails
  gem 'email_spec'
end

group :test do
  gem 'rspec-collection_matchers'
  # Acceptance testing framework
  gem 'cucumber-rails', '>=1.4.0', require: false
  # Capybara provides a DSL for browser automation
  gem 'capybara', '~>2.5.0'
  # Backend for capybara
  gem 'capybara-webkit', '~>1.7.0'
  gem 'capybara-screenshot'
  # Resets state between tests
  gem 'database_cleaner', '>= 1.0.0'
  # debugger
  gem 'byebug', platforms: [:mri_20]
  # Code coverage
  gem 'simplecov', require: false
end
