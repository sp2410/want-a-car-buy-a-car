CarrierWave.configure do |config|
  #config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     Rails.application.secrets.AWS_access_key_id.to_s,                        # required
    aws_secret_access_key: Rails.application.secrets.AWS_secret_access_key.to_s,                        # required
    region:                'us-west-2'                  # optional, defaults to 'us-east-1'
#    host:                  's3.example.com',             # optional, defaults to nil
#    endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }

  config.fog_directory  = 'wacbacassetsdonttouch'                          # required
  
end