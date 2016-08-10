source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5.0.0'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails', git:'https://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'font-awesome-rails'
gem 'underscore-string-rails'
gem 'google-analytics-rails'

group :production do
  gem 'pg'
end

group :production, :development do
  gem 'foreman'
end

group :development, :test do
  gem 'sqlite3'
  gem 'i18n-tasks', require:false
end

group :development do
  gem 'bullet'
  gem 'spring'
  gem 'listen', '~> 3.0.5'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
  gem 'pry-rails'
  gem 'pry-doc', require: false
  gem 'pry-coolline'
  gem 'pry-byebug', platforms: :mri
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
