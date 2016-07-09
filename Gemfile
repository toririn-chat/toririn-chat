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
gem 'foreman'
gem 'underscore-string-rails'

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'redis', '~> 3.0'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry-rails'
  gem 'pry-doc', require: false
  gem 'pry-coolline'
  gem 'pry-byebug', platforms: :mri
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'
  gem 'i18n-tasks', require: false
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
