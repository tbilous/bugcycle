source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '5.1.4'
gem 'sass-rails', '~> 5.0'
# gem 'thor', '0.19.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'therubyracer', '0.12.3', platforms: :ruby
# Use Redis adapter to run Action Cable in production
gem 'jquery-rails'
gem 'redis', '~> 3.0'

# my gems
gem 'active_model_serializers', '0.10.7'
gem 'bootstrap-sass', '3.3.7'
gem 'devise', '4.3.0'
gem 'devise-bootstrap-views', '0.0.11'
gem 'devise-i18n', '1.4.0'
gem 'font-awesome-rails', '4.7.0.2'
gem 'gon', '6.2.0'
gem 'i18n', '0.9.1'
gem 'i18n-js', '3.0.2'
gem 'kaminari', '1.1.1'
gem 'paperclip', '5.1.0'
gem 'rails-i18n', '5.0.4'
gem 'redis-namespace', '1.6.0'
gem 'redis-rails', '5.0.2'
gem 'rspec', '3.7.0'
gem 'sidekiq', '5.0.5'
gem 'sidekiq-status', '0.7.0'
gem 'slim', '3.0.9'
gem 'slim-rails', '3.1.3'
gem 'sprockets', '3.7.1'

# JST
gem 'handlebars_assets', '0.23.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'childprocess'
  gem 'factory_bot_rails', '4.8.2'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'timecop'
  gem 'webmock'
end

group :development do
  gem 'bullet', '5.7.0'
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-linked-files', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rake', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma', require: false
  gem 'letter_opener', '1.4.1'
  gem 'listen', '3.1.5'
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console', '3.5.1'
end

group :test do
  gem 'capybara', '2.16.1'
  gem 'capybara-email', '2.5.0'
  gem 'capybara-webkit', '1.1.0'
  gem 'database_cleaner', '1.6.2'
  gem 'fuubar', '2.2.0'
  gem 'json_spec', '1.1.5'
  gem 'launchy', '2.4.3'
  gem 'rack_session_access', '0.1.1'
  gem 'shoulda-matchers', '3.1.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
