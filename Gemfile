# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "acts-as-taggable-on", "~> 6.0"
gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "puma", "~> 3.7"
gem "pundit"
gem "rails", "~> 5.2.1"
gem "sass-rails", "~> 5.0"
gem "sqlite3"
gem "stripe"
gem "tag-it-rails"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara"
  gem "database_cleaner"
  gem "faker", :git => "https://github.com/faker-ruby/faker.git", :branch => "master"
  gem "factory_bot_rails"
  gem "fuubar"
  gem "rspec-rails"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "webdrivers", "~> 3.0"
end

group :development do
  gem "guard-rspec", require: false
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", "~> 0.63.0", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara-selenium"
  gem "shoulda-matchers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
