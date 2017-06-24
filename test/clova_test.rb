require "test_helper"

class ClovaTest < Minitest::Spec
  it "tts" do
    response = Naver::Clova.tts(
      speaker: "mijin",
      speed: 0,
      text: "기술이 인간을 대체하는 것이 아니라 인간은 기술의 도움으로 더욱 창조적으로 될 것이라는 믿는다."
    )
    # File.open("tts.mp3", "wb") { |f| f.write(response) }
    response.wont_be_nil
  end
end
