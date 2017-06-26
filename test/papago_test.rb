require "test_helper"

class PapagoTest < Minitest::Spec
  it "translate" do
    response = Naver::Papago.translate(
      source: "ko",
      target: "en",
      text: "기술이 인간을 대체하는 것이 아니라 인간은 기술의 도움으로 더욱 창조적으로 될 것이라는 믿는다."
    )
    response.translated_text.wont_be_nil
  end

  it "romanization" do
    response = Naver::Papago.romanization(query: "김수림")
    response.s_first_name.must_equal "김"
    response.a_items[0].name.must_equal "Kim Soorim"
    response.a_items[0].score.must_equal "99"

    response.a_items[1].name.must_equal "Kim Soolim"
    response.a_items[1].score.must_equal "97"

    response.a_items[2].name.must_equal "Kim Surim"
    response.a_items[2].score.must_equal "78"

    response.a_items[3].name.must_equal "Kim Sulim"
    response.a_items[3].score.must_equal "76"
  end
end
