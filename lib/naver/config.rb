module Naver
  module Config
    OPTION_KEYS = [
      :client_id,
      :client_secret,
      :redirect_uri,
      :timeout,
      :debug
    ]

    attr_accessor *OPTION_KEYS

    def configure
      yield self
      self
    end

    def options
      options = {}
      OPTION_KEYS.each { |key| options[key] = send(key) }
      options
    end
  end
end
