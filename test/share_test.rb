require "test_helper"

class ShareTest < Minitest::Spec
  it "share url" do
    url = Naver::Share.url(url: "https://github.com/kimsuelim", title: "The unofficial NAVER SDK for Ruby")
    url.must_equal "http://share.naver.com/web/shareView.nhn?url=https%3A%2F%2Fgithub.com%2Fkimsuelim&title=The+unofficial+NAVER+SDK+for+Ruby"
  end
end
