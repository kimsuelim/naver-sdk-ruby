module Naver # :nodoc:
  # Naver Map API
  class Map < Client
    class << self
      # 주소 -> 좌표 변환
      # @param params [Hash] Params for the search
      def geocode(params = {})
        parse(JSON.parse(connection.get("/v1/map/geocode", params).body)["result"])
      end

      # 좌표 -> 주소 변환
      # @param params [Hash] Params for the search
      def reverse_geocode(params = {})
        params = { query: "#{params[:lat]}, #{params[:lng]}" }
        parse(JSON.parse(connection.get("/v1/map/reversegeocode", params).body)["result"])
      end
    end
  end
end
