module Naver # :nodoc:
  # Naver Shortenurl API
  class Shortenurl < Client
    class << self
      # 단축URL
      # @param url [String] 단축하고자 하는 원본 URL
      def url(url:)
        params = { url: url }
        parse(JSON.parse(connection.post("/v1/util/shorturl", params).body)["result"])
      end
    end
  end
end
