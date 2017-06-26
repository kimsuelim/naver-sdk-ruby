module Naver # :nodoc:
  # Naver Papago API
  class Papago < Client
    class << self
      # 기계번역(Beta)
      # @param source [String] 번역 소스 텍스트의 언어 설정: (ko:한국어, en:영어, ja:일본어, zh-CN:중국어(간체), zh-TW:중국어(번체)
      # @param target [String] 번역 대상 언어, 가능한 값은 source 파라미터와 동일
      # @param text [String] 번역할 문장이며 UTF-8만 지원
      # @return [Hash] 번역된 문장
      def translate(source:, target:, text:)
        params = method(__method__).parameters.map(&:last).map { |p| [p, eval(p.to_s)] }.to_h
        parse(JSON.parse(connection.post("/v1/language/translate", params).body)["message"]["result"])
      end

      # 한글인명 - 로마자 변환
      # @param query [String] 로마자로 바꾸려는 한글 이름
      # @return [Hash] 변환 결과
      def romanization(query:)
        params = { query: query }
        result = JSON.parse(connection.get("/v1/krdict/romanization", params).body)["aResult"][0]
        if result
          result["firstName"] = result.delete("sFirstName")
          result["items"] = result.delete("aItems")
        end
        parse(result)
      end
    end
  end
end
