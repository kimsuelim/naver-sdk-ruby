require "test_helper"

class ConfigTest < Minitest::Spec
  it "must configure the gem with your client_id and client_secret" do
    Naver.client_id.must_equal "GssyV0tCqRYPMRkDKsgG"
    Naver.client_secret.must_equal "ScVEl_cDJA"
    Naver.redirect_uri.must_equal "http://127.0.0.1/oauth/callback"
    Naver.debug.must_equal false
  end
end
