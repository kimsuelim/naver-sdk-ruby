module Naver # :nodoc:
  # Naver Search API
  class Search < Client
    class << self
      # Search > Blog (검색 > 블로그)
      # @param params [Hash] Params for the search
      def blog(params = {})
        parse(JSON.parse(connection.get("/v1/search/blog", params).body))
      end

      # Search > News (검색 > 뉴스)
      # @param params [Hash] Params for the search
      def news(params = {})
        parse(JSON.parse(connection.get("/v1/search/news", params).body))
      end

      # Search > Book (검색 > 책)
      # @param params [Hash] Params for the search
      def book(params = {})
        parse(JSON.parse(connection.get("/v1/search/book", params).body))
      end

      # Search > Adult (검색 > 성인 검색어 판별)
      # @param params [Hash] Params for the search
      def adult(params = {})
        result = JSON.parse(connection.get("/v1/search/adult", params).body)
        if result["adult"] == "1"
          result["adult"] = true
        elsif result["adult"] == "0"
          result["adult"] = false
        end
        parse(result)
      end

      # Search > Encyc (검색 > 백과 사전)
      # @param params [Hash] Params for the search
      def encyc(params = {})
        parse(JSON.parse(connection.get("/v1/search/encyc", params).body))
      end

      # Search > Movie (검색 > 영화)
      # @param params [Hash] Params for the search
      def movie(params = {})
        parse(JSON.parse(connection.get("/v1/search/movie", params).body))
      end

      # Search > Cafearticle (검색 > 카페글)
      # @param params [Hash] Params for the search
      def cafearticle(params = {})
        parse(JSON.parse(connection.get("/v1/search/cafearticle", params).body))
      end

      # Search > Kin (검색 > 지식 iN)
      # @param params [Hash] Params for the search
      def kin(params = {})
        parse(JSON.parse(connection.get("/v1/search/kin", params).body))
      end

      # Search > Local (검색 > 지역)
      # @param params [Hash] Params for the search
      def local(params = {})
        parse(JSON.parse(connection.get("/v1/search/local", params).body))
      end

      # Search > Errata (검색 > 오타변환)
      # @param params [Hash] Params for the search
      def errata(params = {})
        result = JSON.parse(connection.get("/v1/search/errata", params).body)
        result["errata"] = nil if result["errata"] == ""
        parse(result)
      end

      # Search > Webkr (검색 > 웹문서)
      # @param params [Hash] Params for the search
      def webkr(params = {})
        parse(JSON.parse(connection.get("/v1/search/webkr", params).body))
      end

      # Search > Image (검색 > 이미지)
      # @param params [Hash] Params for the search
      def image(params = {})
        parse(JSON.parse(connection.get("/v1/search/image", params).body))
      end

      # Search > Shop (검색 > 쇼핑)
      # @param params [Hash] Params for the search
      def shop(params = {})
        parse(JSON.parse(connection.get("/v1/search/shop", params).body))
      end

      # Search > Doc (검색 > 전문자료)
      # @param params [Hash] Params for the search
      def doc(params = {})
        parse(JSON.parse(connection.get("/v1/search/doc", params).body))
      end
    end
  end
end
