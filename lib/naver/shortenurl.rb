module Naver # :nodoc:
  # Naver Shortenurl API
  class Shortenurl < Client
    class << self
      # 단축URL
      # @param params [Hash] Params for the origin url
      def url(params = {})
        parse(JSON.parse(connection.post("/v1/util/shorturl", params).body)["result"])
      end
    end
  end
end
