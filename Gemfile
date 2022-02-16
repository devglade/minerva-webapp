source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails'
  gem 'forgery'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'rb-readline' #rails console 이 동작이 안되서 추가;
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.10'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rack'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'

  # 개발시에는 편지를 브라우져에서 오픈하도록 만들어주는 GEM
  gem 'letter_opener'
  # help to kill N+1 queries and unused eager loading. https://github.com/flyerhzm/bullet
  gem 'bullet'
end

gem 'acts_as_votable', '~> 0.12.0'

gem 'bootstrap', '~> 4.0.0'
gem 'bootstrap-social-rails'
gem 'bootstrap_form'
gem 'font-awesome-rails'

gem 'bourbon' #https://github.com/thoughtbot/bourbon

gem 'cloudinary'

gem 'devise'
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'material_icons'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'acts_as_list'

gem 'webpacker', '~> 3.5' #https://github.com/rails/webpacker

gem 'inline_svg'

gem 'sendgrid-ruby'

gem 'ffi', '~> 1.13'