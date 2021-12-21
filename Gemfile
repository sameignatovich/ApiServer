source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jbuilder"
# gem "kredis"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "rack-cors"

gem "passenger"
gem "sidekiq"
gem "jwt"
gem "kaminari"
gem "has_scope"
gem "faker", require: false
gem "avatarly", require: false
gem "stringio", require: false
gem "ruby-progressbar", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-rvm"
  gem "ed25519"
  gem "bcrypt_pbkdf"
end