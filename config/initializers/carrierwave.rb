CarrierWave.configure do |config|
  #config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_access_key_id"],                        # required
    aws_secret_access_key: ENV["AWS_secret_access_key"],                        # required
    region:                'us-west-2'                  # optional, defaults to 'us-east-1'
#    host:                  's3.example.com',             # optional, defaults to nil
#    endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }

  config.fog_directory  = 'wacbacassetsdonttouch'                          # required
  
end