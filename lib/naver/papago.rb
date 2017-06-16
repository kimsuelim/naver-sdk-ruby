module Naver # :nodoc:
  # Naver Papago API
  class Papago < Client
    class << self
      # 기계번역(Beta)
      # @param params [Hash] Params for the translate
      def translate(params = {})
        parse(JSON.parse(connection.post("/v1/language/translate", params).body)["message"]["result"])
      end

      # 한글인명 - 로마자 변환
      # @param params [Hash] Params for the translate
      def romanization(params = {})
        parse(JSON.parse(connection.get("/v1/krdict/romanization", params).body)["aResult"][0])
      end
    end
  end
end
