require "test_helper"

class ShorturlTest < Minitest::Spec
  it "shortenurl" do
    response = Naver::Shorturl.shorten(url: "https://github.com/kimsuelim")
    response.hash.wont_be_nil
    response.url.wont_be_nil
    response.orgUrl.must_equal "https://github.com/kimsuelim"
  end
end
