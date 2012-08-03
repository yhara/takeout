source 'https://rubygems.org'

gem 'rails', '3.2.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

gem "friendly_id", "~> 4.0.8"

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
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem "slim-rails"
gem "sqlite3", :group => [:development, :test]
#group :production do
#  gem "pg"
#  gem "therubyracer-heroku", "0.8.1.pre3"
#end

group :development do
  gem "pry-rails"
end

group :development, :test do
  gem "awesome_print"
  gem "tapp"
end

group :test do
  gem "test-unit", ">= 2.5.1"
  gem "shoulda-context"
  gem "mocha", require: false
end
