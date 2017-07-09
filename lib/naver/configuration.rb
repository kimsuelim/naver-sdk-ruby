module Naver
  # Defines constants and methods related to configuration.
  module Configuration
    # An array of valid keys in the options hash when configuring a Naver::Client.
    OPTION_KEYS = [:client_id, :client_secret, :redirect_uri, :timeout, :debug].freeze

    # The user agent that will be sent to the API endpoint if none is set.
    DEFAULT_USER_AGENT = "NAVER Ruby SDK Gem #{Naver::Sdk::VERSION}".freeze

    # Base URI for the NAVER API.
    DEFAULT_API_BASE_URI = "https://openapi.naver.com".freeze

    # Base URI for NAVER OAuth.
    DEFAULT_OAUTH_BASE_URI = "https://nid.naver.com".freeze

    attr_accessor *OPTION_KEYS

    # Convenience method to allow configuration options to be set in a block.
    def configure
      yield(self)
    end

    # Creates a hash of options and their values.
    def options
      options = {}
      OPTION_KEYS.each { |key| options[key] = send(key) }
      options
    end
  end
end
