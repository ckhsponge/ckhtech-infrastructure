require 'dynamoid'

if development?
  # bin/start_dynamodb.sh
  Dynamoid.configure do |config|
    # config.endpoint = "http://localhost:4566" # localstack
    config.endpoint = "http://localhost:8000" # gem version, faster
    config.access_key = 'test'
    config.secret_key = 'test'
    config.region = ENV['DYNAMODB_REGION'] || 'us-east-1'
  end
else
  Dynamoid.configure do |config|
    config.namespace = nil
    # config.credentials = Aws::InstanceProfileCredentials.new
    config.region = ENV['DYNAMODB_REGION']
    # TODO how can lower the retry limit from 10 to 2?
  end
end

