source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use thin as the app server
gem 'thin'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# Template engine
gem 'slim-rails'

# permissions and things
gem 'cancan'

# nested forums and the likes
gem 'ancestry'

# allows MTA calls to rails
gem 'mta_json', '~> 0.0.2'

# colorful output
gem 'win32console', :platforms => :mingw

# pagination
gem 'kaminari'

# formatting options
gem 'creole'

# mostly tests
group :development, :test do
  gem 'rspec-rails'
end
group :test do
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov'
end
