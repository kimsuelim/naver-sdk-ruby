$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "naver/sdk"

require "minitest/autorun"
require "minitest/pride"
require "coveralls"
Coveralls.wear!

Naver.configure do |config|
  config.client_id = "GssyV0tCqRYPMRkDKsgG"
  config.client_secret = "ScVEl_cDJA"
  config.redirect_uri = "http://127.0.0.1/oauth/callback"
  config.timeout = 10
  config.debug = false
end
