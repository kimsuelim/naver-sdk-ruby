require "oauth2"
require "faraday"

require "naver/sdk/version"
require "naver/config"
require "naver/connection"
require "naver/client"
require "naver/error"
require "naver/oauth"
require "naver/objectified_hash"

require "naver/map"
require "naver/papago"
require "naver/profile"
require "naver/search"
require "naver/share"
require "naver/shorturl"
require "naver/vision"
require "naver/voice"

module Naver
  extend Config

  module Sdk
  end
end
