$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'refinery/api'
require 'vcr'
require 'pry'

require "support/request_helpers"
require "support/fixture_helpers"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.include Requests::JsonHelper
  config.include Fixtures::Helper

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    Refinery::API.configure do |conf|
      conf.api_token = "123"
      conf.api_url = "http://localhost:3000"
      conf.api_path = "/api/v1"
    end
  end
end
