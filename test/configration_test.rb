require "test_helper"

class ConfigTest < Minitest::Spec
  it "user_agent" do
    Naver::Configration::DEFAULT_USER_AGENT.must_equal "NAVER Ruby SDK Gem #{Naver::Sdk::VERSION}"
  end

  it "api_base_uri" do
    Naver::Configration::DEFAULT_API_BASE_URI.must_equal "https://openapi.naver.com"
  end

  it "oauth_base_uri" do
    Naver::Configration::DEFAULT_OAUTH_BASE_URI.must_equal "https://nid.naver.com"
  end

  it "must configure the gem with your client_id and client_secret" do
    Naver.client_id.must_equal "GssyV0tCqRYPMRkDKsgG"
    Naver.client_secret.must_equal "ScVEl_cDJA"
    Naver.redirect_uri.must_equal "http://127.0.0.1/oauth/callback"
    Naver.timeout.must_equal 10
    Naver.debug.must_equal false
  end
end
