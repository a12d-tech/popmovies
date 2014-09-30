$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'popmovies'

RSpec.configure do |config|
  config.mock_framework = :rspec
end
