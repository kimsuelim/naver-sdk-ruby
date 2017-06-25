require "test_helper"

class VoiceTest < Minitest::Spec
  it "tts" do
    response = Naver::Voice.tts(
      speaker: "mijin",
      speed: 0,
      text: "기술은 사람을 대체하는 것이 아니라 기술의 도움으로 사람을 더 창조적으로 만들 것이라 믿는다."
    )
    # File.open("tts.mp3", "wb") { |f| f.write(response) }
    response.wont_be_nil
  end
end
