require "test_helper"

class SearchTest < Minitest::Spec
  it "blog" do
    response = Naver::Search.blog(query: "블로그")
    common_assertions(response)
  end

  it "news" do
    response = Naver::Search.news(query: "뉴스")
    common_assertions(response)
  end

  it "book" do
    response = Naver::Search.book(query: "집밥")
    common_assertions(response)
  end

  it "adult" do
    response = Naver::Search.adult(query: "청소년")
    response.adult.must_equal "0"

    response = Naver::Search.adult(query: "성인")
    response.adult.must_equal "1"
  end

  it "encyc" do
    response = Naver::Search.encyc(query: "집밥")
    common_assertions(response)
  end

  it "movie" do
    response = Naver::Search.movie(query: "킬빌")
    common_assertions(response)
  end

  it "cafearticle" do
    response = Naver::Search.cafearticle(query: "집밥")
    common_assertions(response)
  end

  it "kin" do
    response = Naver::Search.kin(query: "집밥")
    common_assertions(response)
  end

  it "local" do
    response = Naver::Search.local(query: "집밥")
    common_assertions(response)
  end

  it "errata" do
    response = Naver::Search.errata(query: "집밥")
    response.errata.must_equal ""

    response = Naver::Search.errata(query: "wlqqkq")
    response.errata.must_equal "집밥"
  end

  it "webkr" do
    response = Naver::Search.webkr(query: "집밥")
    common_assertions(response)
  end

  it "image" do
    response = Naver::Search.image(query: "집밥")
    common_assertions(response)
  end

  it "shop" do
    response = Naver::Search.shop(query: "플스4")
    common_assertions(response)
  end

  it "doc" do
    response = Naver::Search.doc(query: "집밥")
    common_assertions(response)
  end

  private

  def common_assertions(response)
    response.lastBuildDate.wont_be_nil
    response.total.wont_be_nil
    response.start.must_equal 1
    # response.display.wont_be_nil
    response.items.must_be_instance_of Array
  end
end
