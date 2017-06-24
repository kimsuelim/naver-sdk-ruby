module Naver # :nodoc:
  # Naver Share
  class Share
    class << self
      # 네이버 공유하기
      # @param url [String] url for the share url
      # @param title [String] title for the share url
      def url(url:, title:)
        naver_url = "http://share.naver.com/web/shareView.nhn?"
        query = URI.encode_www_form(url: url, title: title)
        "#{naver_url}#{query}"
      end
    end
  end
end
