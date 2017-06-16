require "test_helper"

class ShortenurlTest < Minitest::Spec
  it "shortenurl" do
    response = Naver::Shortenurl.url(url: "https://github.com/kimsuelim")
    response.hash.wont_be_nil
    response.url.wont_be_nil
    response.orgUrl.must_equal "https://github.com/kimsuelim"
  end
end
