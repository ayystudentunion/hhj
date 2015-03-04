source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
gem 'stylus', '~> 1.0.1'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.3'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2.8'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'slim', '~> 3.0.2'
gem 'execjs', '~> 2.3.0'

gem 'mongoid', '~> 4.0.2'
gem 'bson_ext', '~> 1.5.1'
gem 'mongoid_rails_migrations', '~> 1.1.0'
gem 'mongoid-tree', '~> 2.0.0'

gem 'rails_admin', '~> 0.6.6'
gem 'devise', '~> 3.4.1'

gem 'wkhtmltopdf-binary', '~> 0.9.9.3'
gem 'wicked_pdf', '~> 0.11.0'
gem 'valid_email', '~> 0.0.10'
gem 'redcarpet', '~> 3.2.2'
gem 'gritter', '~> 1.1.0'
gem 'airbrake', '~> 4.1.0'
gem 'sucker_punch', '~> 1.3.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 3.5.1'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.2'

  gem 'rspec-rails', '~> 3.2.0'
  gem 'mongoid-rspec', '~> 2.1.0'
  gem 'factory_girl_rails', require: false
  gem 'letter_opener', '~> 1.3.0'
  gem 'email_spec', '~> 1.6.0'
end

group :development do
  # gem 'mongrel'
  gem 'better_errors', '~> 2.1.1'
  gem 'meta_request', '~> 0.3.4'
end

group :test do
  # gem 'rspec_multi_matchers'#, '~> 1.2.1'
  gem 'cucumber-rails', '~> 1.4.2', require: false
  # restricting until capybara-webkit releases a version compatible with 2.1
  gem 'capybara', '~> 2.4.4'
  gem 'capybara-webkit', '~> 1.4.1'
  gem 'capybara-screenshot', '~> 1.0.5'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner', '~> 1.4.0'
  gem 'launchy', '~> 2.4.3'
  gem 'wait_for', '~> 0.1.1'
  gem 'simplecov', '~> 0.9.2', :require => false
  # gem 'debugger' # Only 1.9.2 and 1.9.3 are supported. For 2.X rubies, use byebug.
end

# Use Capistrano for deployment
gem 'capistrano-rails', '~> 1.1.2', group: :development
gem 'rvm-capistrano', '~> 1.5.0', group: :development
