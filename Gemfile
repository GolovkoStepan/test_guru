# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap4-kaminari-views'
gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'devise-i18n'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'octokit', '~> 4.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.1.4.6', '< 7'
gem 'rails-i18n'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'letter_opener'
end

group :development do
  gem 'annotate'
  gem 'brakeman', require: false
  gem 'listen', '~> 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
