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
    response = Naver::Search.book(query: "책")
    common_assertions(response)
  end

  it "adult" do
    response = Naver::Search.adult(query: "청소년")
    response.adult.must_equal false

    response = Naver::Search.adult(query: "성인")
    response.adult.must_equal true
  end

  it "encyc" do
    response = Naver::Search.encyc(query: "백과 사전")
    common_assertions(response)
  end

  it "movie" do
    response = Naver::Search.movie(query: "킬빌")
    common_assertions(response)
  end

  it "cafearticle" do
    response = Naver::Search.cafearticle(query: "카페글")
    common_assertions(response)
  end

  it "kin" do
    response = Naver::Search.kin(query: "지식인")
    common_assertions(response)
  end

  it "local" do
    response = Naver::Search.local(query: "제주도")
    common_assertions(response)
  end

  it "errata" do
    response = Naver::Search.errata(query: "오타")
    response.errata.must_be_nil

    response = Naver::Search.errata(query: "dhxk")
    response.errata.must_equal "오타"
  end

  it "webkr" do
    response = Naver::Search.webkr(query: "웹문서")
    common_assertions(response)
  end

  it "image" do
    response = Naver::Search.image(query: "이미지")
    common_assertions(response)
  end

  it "shop" do
    response = Naver::Search.shop(query: "쇼핑")
    common_assertions(response)
  end

  it "doc" do
    response = Naver::Search.doc(query: "전문자료")
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
