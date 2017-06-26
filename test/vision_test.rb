require "test_helper"

class VisionTest < Minitest::Spec
  it "celebrity" do
    response = Naver::Vision.celebrity(image: "test/resources/park.png")
    response.info.size.wont_be_nil
    response.info.face_count.must_equal 1
    response.faces.must_be_instance_of Array
    response.faces[0].celebrity.value.must_equal "박성웅"
    response.faces[0].celebrity.confidence.must_equal 1.0
  end

  it "face" do
    response = Naver::Vision.face(image: "test/resources/park.png")
    response.info.size.wont_be_nil
    response.faces.must_be_instance_of Array
    response.faces[0].gender.value.must_equal "male"
    response.faces[0].emotion.value.must_equal "smile"
  end
end
