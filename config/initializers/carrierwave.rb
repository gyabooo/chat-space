require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'

  if Rails.env.development?
    config.fog_credentials = {
      provider: 'AWS',
      region: 'ap-northeast-1',
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key
    }
  else
    config.fog_credentials = {
      provider: 'AWS',
      region: 'ap-northeast-1',
      use_iam_profile: true
    }
  end

  config.fog_directory  = 'gyabooo-chat-space'
  config.asset_host = "https://#{config.fog_directory}.s3-ap-northeast-1.amazonaws.com"
end