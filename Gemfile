source 'https://rubygems.org'

# ruby '2.3.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'#, '4.2.6'
# Use sqlite3 as the database for Active Record
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# ADDING OUR GEMS HERE
gem 'haml'
gem 'figaro'
gem 'google-api-client'
gem "omniauth-google-oauth2"
gem 'fullcalendar-rails'
gem 'momentjs-rails'
gem 'jquery-turbolinks'
gem 'coveralls', require: false

group :development, :test do
  gem 'byebug'
  gem 'sqlite3'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails'
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
  gem 'autotest-rails'
  gem 'factory_girl_rails'
  #gem 'metric-fu'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  # gem 'sqlite3'
end