Sidekiq.configure_client do |config|
	config.redis = {db: 0, url: ENV["REDISTOGO_URL"] || 'redis://localhost:6379/0'}
end

Sidekiq.configure_server do |config|
	config.redis = {db: 0, url: ENV["REDISTOGO_URL"] || 'redis://localhost:6379/0'}
end

# # REDIS = Redis.new(:url => )
