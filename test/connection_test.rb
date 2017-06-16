require "test_helper"

class ConnectionTest < Minitest::Spec
  it "initilize connection" do
    connection = Naver::Client.connection
    connection.instance_variable_get(:@client_id).must_equal "GssyV0tCqRYPMRkDKsgG"
    connection.instance_variable_get(:@client_secret).must_equal "ScVEl_cDJA"
    connection.instance_variable_get(:@api_base_uri).must_equal "https://openapi.naver.com"
  end
end
