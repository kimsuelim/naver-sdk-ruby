module Naver # :nodoc:
  # Naver Voice API
  class Voice < Client
    class << self
      # 음성합성(Beta)
      # @param speaker [String] 음성 합성할 목소리 설정: ( mijin:미진(한국어, 여성), jinho:진호(한국어, 남성), clara:클라라(영어, 여성), matt:매튜(영어, 남성), yuri:유리(일본어, 여성), shinji:신지(일본어, 남성), meimei:메이메이(중국어, 여성))
      # @param speed [Integer] -5 ~ 5 사이 정수로 -5면 0.5배 빠른, 5면 0.5배 느린, 0이면 정상 속도의 목소리로 합성
      # @param text [String] 음성합성할 문장이며 UTF-8만 지원
      # @return [Binary] Content-Type이 audio/mpeg인 mp3 음원 파일
      def tts(speaker:, speed:, text:)
        params = method(__method__).parameters.map(&:last).map { |p| [p, eval(p.to_s)] }.to_h
        connection.post("/v1/voice/tts.bin", params).body
      end
    end
  end
end
