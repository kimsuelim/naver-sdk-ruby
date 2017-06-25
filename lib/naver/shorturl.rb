module Naver # :nodoc:
  # Naver Shorturl API
  class Shorturl < Client
    class << self
      # 단축URL
      # @param url [String] 단축하고자 하는 원본 URL
      # @return [ObjectifiedHash] 단축 결과
      def shorten(url:)
        params = { url: url }
        parse(JSON.parse(connection.post("/v1/util/shorturl", params).body)["result"])
      end
    end
  end
end
