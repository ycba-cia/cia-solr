source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.10'

gem 'rails', '~> 8.1'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 2.0'

# Use Puma as the app server
gem 'puma', '~> 6.4'
gem 'puma-daemon', require: false

# Asset pipeline (keeping Sprockets for existing app; Rails 8 defaults to Propshaft)
gem 'sprockets-rails'
gem 'sass-rails', '~> 6.0'
# JavaScript minifier (replaces uglifier which required ExecJS)
gem 'terser'

# Hotwire — replaces Turbolinks
gem 'turbo-rails'
gem 'stimulus-rails'

# Build JSON APIs with ease
gem 'jbuilder', '~> 2.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Ruby debugger (replaces byebug)
  gem 'debug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.2.0'
  gem 'listen', '>= 3.3'
end

group :test do
  gem 'capybara', '>= 3.38'
  gem 'selenium-webdriver'
  # selenium-webdriver 4+ manages chromedriver automatically; no chromedriver-helper needed
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'rsolr'

#gem 'nokogiri', '~> 1.14.3'
gem 'nokogiri', '~> 1.19' #, force_ruby_platform: true

gem "rack", ">= 2.2.3"

gem "addressable", ">= 2.8.0"

gem 'mysql2', '~> 0.5.3'

gem 'devise'

#https://github.com/yalelibrary/yul-dc-blacklight/blob/main/Gemfile
gem 'omniauth', '~> 2.1'
gem 'omniauth-cas', '~> 3.0.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0.2'

gem 'sorted_set'

gem 'kaminari'

#gem 'tiny_tds', '1.3.0'
gem 'tiny_tds', '3.2.1'

#gem 'bundler', '2.5.18'
