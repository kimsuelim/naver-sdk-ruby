require "test_helper"

class MapTest < Minitest::Spec
  it "geocode" do
    response = Naver::Map.geocode(query: "불정로 6")
    response.total.must_equal 1
    response.userquery.must_equal "불정로 6"
    response.items.must_be_instance_of Array
    response.items[0].point.x.must_equal 127.1052133
    response.items[0].point.y.must_equal 37.3595316
  end

  it "reverse_geocode" do
    response = Naver::Map.reverse_geocode(lat: "127.1141382", lng: "37.3599968")
    response.total.must_equal 2
    response.userquery.must_equal "127.1141382, 37.3599968"
    response.items.must_be_instance_of Array
    response.items[0].address.must_equal "경기도 성남시 분당구 정자동 257-1"
    response.items[0].addrdetail.country.must_equal "대한민국"
    response.items[0].addrdetail.sido.must_equal "경기도"
    response.items[0].addrdetail.sigugun.must_equal "성남시 분당구"
    response.items[0].addrdetail.dongmyun.must_equal "정자동"
    response.items[0].addrdetail.rest.must_equal "257-1"
    response.items[0].is_adm_address.must_equal false
    response.items[0].is_road_address.must_equal false
    response.items[0].point.x.must_equal 127.1164925
    response.items[0].point.y.must_equal 37.3597611
  end
end
