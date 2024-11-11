# Load the Rails application.
require_relative 'application'

env_config = File.join(Rails.root, 'config', 'env_config.rb')
load(env_config) if File.exist?(env_config)

# Initialize the Rails application.
Rails.application.initialize!
