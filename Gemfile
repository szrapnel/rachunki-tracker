# source 'https://rubygems.org'
source 'http://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'formtastic'

gem 'draper'

gem 'devise'

gem 'rails_12factor', group: :production

gem 'tzinfo-data'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'airbrake'

group :production do
  gem 'pg'
end

group :development, :test do
# Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'dotenv-rails'
end


#////////////////////// my gems

# gem 'better_errors', :require => false, :group => :development
# gem 'binding_of_caller', :require => false, :group => :development
# nie wiem czemu one nie dzialaja z travisem ale bedzie to trzeba jakos ogarnac jeszcze
# z heroku tez nie
# moze wina wersji tylko travic pisze o jakiejs niezgodnosci miedzy 210 a 200

# sprawdz co robi require

gem 'simplecov', :require => false, :group => :test

gem 'codeclimate-test-reporter', group: :test, require: nil
