Sidekiq.configure_client do |config|
	config.redis = {size: 7, url: ENV["REDISCLOUD_URL"] || 'redis://localhost:6379/0'}
end

Sidekiq.configure_server do |config|
	config.redis = {url: ENV["REDISCLOUD_URL"] || 'redis://localhost:6379/0'}
	schedule_file = "config/schedule.yml"
  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end