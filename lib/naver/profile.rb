module Naver # :nodoc:
  # 네이버 회원 프로필 조회
  class Profile < Client
    class << self
      # 회원 프로필
      def me
        parse(JSON.parse(connection.get("/v1/nid/me").body)["response"])
      end
    end
  end
end
