source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'jwt', '~> 1.5', '>= 1.5.4'
gem 'rack-cors'
gem 'sidekiq', '~> 4.1', '>= 4.1.2'
gem "sidekiq-cron", "~> 1.1"
gem 'foreman', '~> 0.87.2'
gem 'net-ssh', '>= 6.0.2'
gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rails', '~> 1.5', require: false
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-db-tasks', require: false
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
