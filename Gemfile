source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'puma', '~> 3.11'
gem 'google-analytics-rails'
gem 'devise'
gem 'devise-i18n'
gem 'webpacker'
gem 'carrierwave'
gem 'active_model_serializers', '~> 0.10'
gem 'enumerize', '~> 2.1'
gem 'rqrcode', '~> 0.10'
gem 'bootsnap', '>= 1.1.0', require: false

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'license_finder'
  gem 'dotenv-rails'
  gem 'faker'
end

group :production, :development do
  gem 'foreman'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  gem 'pry-rails'
  gem 'pry-doc', require: false
  gem 'pry-coolline'
  gem 'pry-byebug', platforms: :mri
  gem 'awesome_print'
  gem 'i18n-tasks', require:false
  gem 'guard-livereload', require:false
  gem 'letter_opener'
  gem 'letter_opener_web'
end

group :test do
  gem 'capybara', '~> 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'minitest-reporters'
  gem 'minitest-power_assert'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
