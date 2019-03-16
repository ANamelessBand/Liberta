# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.0"

gem "rails", "~> 5.2.2"
gem "sqlite3", "~> 1.3.6"
gem "puma", "~> 3.11"

gem "bootstrap"
gem "jquery-rails"
gem "sass-rails", "~> 5.0"
gem "uglifier", "~> 1.3.0"
gem "font-awesome-rails"

gem "jquery-ui-rails"
gem "rails-jquery-autocomplete"

gem "slim-rails"
gem "rails-i18n"

gem "devise"
gem "omniauth-google-oauth2"

gem "kaminari"
gem "breadcrumbs_on_rails"

gem "travis"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.1.0", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console", "~> 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  gem "rubocop", require: false
  gem "rubocop-rails_config", require: false
end

group :test do
  gem "shoulda-matchers"
  gem 'coveralls', require: false
end

group :tasks do
  gem "rspec"
end
