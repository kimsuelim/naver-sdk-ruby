require "test_helper"

class OauthTest < Minitest::Spec
  let(:oauth) { Naver::Oauth.new }

  it "initilize oauth" do
    oauth.instance_variable_get(:@client_id).must_equal "GssyV0tCqRYPMRkDKsgG"
    oauth.instance_variable_get(:@client_secret).must_equal "ScVEl_cDJA"
    oauth.instance_variable_get(:@oauth_base_uri).must_equal "https://nid.naver.com"
    oauth.instance_variable_get(:@redirect_uri).must_equal "http://127.0.0.1/oauth/callback"
    oauth.instance_variable_get(:@oauth).wont_be_nil
  end

  it "Direct them to the NAVER authorization URL" do
    oauth.authorization_url.must_equal "https://nid.naver.com/oauth2.0/authorize?client_id=GssyV0tCqRYPMRkDKsgG&redirect_uri=http%3A%2F%2F127.0.0.1%2Foauth%2Fcallback&response_type=code&scope=public"
  end

  it "extract token" do
    stub = { "token_type" => "bearer", :access_token => "AAAAOVdlgUlGTej6GJj2olv2cyPGiLdFX/oT3u29i48PtUYAQmahbfP58ItCdanZz7nninqZNmQWiDVaXy26zk8rny8=", :refresh_token => "fXKPyKGM2zfAxfgrDQKBA60CKsM8h9BlfqisQvtTiiWnwF5vYlAghIBSu6WvNrSmDLCCmKrfVFipEbJurOxFLoW6NdohlIqCp4mSdviiHZxLTYR0aPwnbxWmkByk70ZisuX3A", :expires_at => 1498105810 }
    oauth.stub(:extract_token, stub) do
      oauth.extract_token.must_equal stub
    end
  end
end
