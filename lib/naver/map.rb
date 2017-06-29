module Naver # :nodoc:
  # Naver Map API
  class Map < Client
    class << self
      # 주소를 좌표로 변환
      # @param params [Hash] Params for the search
      def geocode(params = {})
        parse(JSON.parse(connection.get("/v1/map/geocode", params).body)["result"])
      end

      # 좌표를 주소로 변환
      # @param params [Hash] Params for the search
      def reverse_geocode(params = {})
        params = { query: "#{params[:lat]}, #{params[:lng]}" }
        parse(JSON.parse(connection.get("/v1/map/reversegeocode", params).body)["result"])
      end

      # StaticMap
      # 지정된 좌표의 네이버 지도 이미지를 출력
      # @param params [Hash] Params for the search
      def static_map(params = {})
        connection.get("/v1/map/staticmap.bin", params).body
      end
    end
  end
end
