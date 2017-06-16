require "test_helper"

class MapTest < Minitest::Spec
  it "geocode" do
    response = Naver::Map.geocode(query: "불정로 6")
    response.must_be_instance_of Array
    response[0].point.x.must_equal 127.1052133
    response[0].point.y.must_equal 37.3595316
  end

  it "reverse_geocode" do
    response = Naver::Map.reverse_geocode(lat: "127.1141382", lng: "37.3599968")
    response.must_be_instance_of Array
    response[0].address.must_equal "경기도 성남시 분당구 정자동 257-1"
    response[0].addrdetail.country.must_equal "대한민국"
    response[0].addrdetail.sido.must_equal "경기도"
    response[0].addrdetail.sigugun.must_equal "성남시 분당구"
    response[0].addrdetail.dongmyun.must_equal "정자동"
    response[0].addrdetail.rest.must_equal "257-1"
    response[0].isAdmAddress.must_equal false
    response[0].isRoadAddress.must_equal false
    response[0].point.x.must_equal 127.1164925
    response[0].point.y.must_equal 37.3597611
  end
end
