module Naver # :nodoc:
  # Naver Vision API
  class Vision < Client
    class << self
      # 유명인 얼굴인식(Beta)
      # @param image [Binary] 얼굴이 포함된 이미지 (최대 2MB)
      # @return [ObjectifiedHash] 인식결과
      def celebrity(image:)
        params = {}
        params[:image] = Faraday::UploadIO.new(image, "image/jpeg")
        parse(JSON.parse(connection.post("/v1/vision/celebrity", params).body))
      end

      # 얼굴 감지(Beta)
      # @param image [Binary] 얼굴이 포함된 이미지 (최대 2MB)
      # @return [ObjectifiedHash] 인식결과
      def face(image:)
        params = {}
        params[:image] = Faraday::UploadIO.new(image, "image/jpeg")
        parse(JSON.parse(connection.post("/v1/vision/face", params).body))
      end
    end
  end
end
