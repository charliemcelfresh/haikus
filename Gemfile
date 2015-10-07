source 'https://rubygems.org'

ruby "2.2.2"

gem 'rails', '4.2.4'
gem 'bcrypt'
gem "active_model_serializers", github: "rails-api/active_model_serializers"
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'figaro'

group :development, :test do
  gem 'spring'  
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'rspec_api_documentation'
  gem 'rspec-rails', '~> 3.0'
  gem 'sqlite3'
  gem 'simplecov', :require => false
end

group :production do
  gem 'pg'
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
end

