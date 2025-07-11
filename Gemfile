source "https://rubygems.org"

gem 'devise', '~> 4.9'
gem "rails", "~> 8.0.2"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "pundit", "~> 2.5"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem 'dotenv-rails', '~> 2.8'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'pry-byebug', '~> 3.10'
  gem 'pry-rails', '~> 0.3'
end

group :development do
  gem "web-console"
  gem 'annotate', '< 3.2.0'
  gem 'better_errors', '~> 2.10', '>= 2.10.1'
  gem 'rubocop', '~> 1.78'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
