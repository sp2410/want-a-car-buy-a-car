source 'http://rubygems.org'
#ruby "~> 2.3.0"

#lolakutti

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


gem 'redis'

#gem 'json'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'bootstrap-sass'
gem 'geocoder'

gem 'bootstrap_form'

gem 'devise'
#gem 'pundit'
# gem 'cancancan', '~> 1.9'
gem "sidekiq"

gem 'friendly_id', '~> 5.1.0'


gem 'sdoc', '~> 0.4.0'

gem 'ckeditor', '~> 4.1'

# gem 'filterrific'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.3'

#gem 'rmagick', '~> 2.3.0'


#beautiful alerts
gem 'slide-down-alerts-rails'
#gem 'sprockets-rails', :require => 'sprockets/railtie'
gem "fog-aws"

gem 'figaro'

gem 'social-share-button', github: "huacnlee/social-share-button"
# gem 'filterrific'

# gem 'forty_facets', github: "sp2410/forty_facets"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#Text Notification
gem 'twilio-ruby', '~> 4.11.1'

#email notifications
gem 'sendgrid-ruby'

#For importing bulk csv
gem 'activerecord-import'

gem 'smarter_csv'

gem 'recaptcha', require: 'recaptcha/rails'

# gem 'will_paginate', '~> 3.0.5'

# gem 'bootstrap-will_paginate', '~> 0.0.10'



group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.6'	
  gem "factory_bot_rails", "~> 4.0"
  gem 'database_cleaner'
  gem 'seed_dump'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


gem 'activeadmin', github: 'activeadmin'

gem 'active_admin_importable'

# gem 'tire'

gem 'elasticsearch-model'

gem 'forty_facets'



group :development do  
	# Use sqlite3 as the database for Active Record
	# gem 'sqlite3'	
	 gem 'mysql2', '0.3.21'
end

# group :test do 
# 	# Use sqlite3 as the database for Active Record
# 	# gem 'sqlite3'	
# 	gem 'sqlite3'	
# end

group :production do 	
	gem 'pg', '~> 0.20'
	gem 'rails_12factor'
	#new relic monitoring
	# gem 'newrelic_rpm'
	# gem "skylight"
	gem 'heroku-deflater'

end
