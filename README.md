# NAVER SDK for Ruby

[![Build Status](https://travis-ci.org/kimsuelim/naver-sdk-ruby.svg?branch=master)](https://travis-ci.org/kimsuelim/naver-sdk-ruby)
[![Coverage Status](https://coveralls.io/repos/github/kimsuelim/naver-sdk-ruby/badge.svg?branch=master)](https://coveralls.io/github/kimsuelim/naver-sdk-ruby?branch=master)
[![Gem Version](https://badge.fury.io/rb/naver-sdk.svg)](https://badge.fury.io/rb/naver-sdk)

A ruby client for the NAVER API. [https://developers.naver.com](https://developers.naver.com)
## Installation

Add this line to your application's Gemfile:

```ruby
gem "naver-sdk"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install naver-sdk

## Usage

### Configuration

Before making requests, you must configure the gem with your client ID
and secret. If you are using Rails, you can do this in an initializer. 

요청하기 전에 애플리케이션 등록 시 발급받은 Client ID와 Client Secret 값을 설정해주셔야 활용 가능합니다.
Rails를 사용하고 있다면 initializer에서 할 수 있습니다.

```ruby
Naver.configure do |config|
  config.client_id     = "YOUR CLIENT ID"
  config.client_secret = "YOUR CLIENT SECRET"
  config.redirect_uri  = "https://your-application.com/oauth/callback"
  config.timeout = 10
  config.debug = false
end
```

## 얼굴인식
입력된 얼굴 사진을 분석해서 닮은 연예인이나 얼굴 감지

### 유명인 얼굴인식(Beta)
```
response = Naver::Vision.celebrity(image: "test/resources/park.png")
# => #<Naver::ObjectifiedHash:70286633240760 {hash: {
  "info"=>{
    "size"=>{"width"=>683, "height"=>377},
    "faceCount"=>1
  },
  "faces"=>[
    {"celebrity"=>{"value"=>"박성웅", "confidence"=>1.0}}
  ]
}}

puts response.faces[0].celebrity.value
# => "박성웅"
```

테스트에서 사용한 이미지 보기 [test/resources/park.png](test/resources/park.png)

### 얼굴 감지(Beta)
```
response = Naver::Vision.face(image: "test/resources/park.png")
# => #<Naver::ObjectifiedHash:70286633075440 {hash: {
  "info"=>{"size"=>{"width"=>683, "height"=>377}, "faceCount"=>1},
  "faces"=>[
    {
      "roi"=>{"x"=>214, "y"=>106, "width"=>117, "height"=>117},
      "landmark"=>{
        "leftEye"=>{"x"=>241, "y"=>137},
        "rightEye"=>{"x"=>296, "y"=>126},
        "nose"=>{"x"=>271, "y"=>166},
        "leftMouth"=>{"x"=>250, "y"=>195},
        "rightMouth"=>{"x"=>309, "y"=>185}
      },
      "gender"=>{"value"=>"male", "confidence"=>0.999884},
      "age"=>{"value"=>"44~48", "confidence"=>0.79507},
      "emotion"=>{"value"=>"smile", "confidence"=>0.988639},
      "pose"=>{"value"=>"frontal_face", "confidence"=>0.99785}
    }
  ]
}}

puts response.faces[0].gender.value
# => "male"

puts response.faces[0].emotion.value
# => "smile"
```

테스트에서 사용한 이미지 보기 [test/resources/park.png](test/resources/park.png)

## 지도

### 주소 -> 좌표 변환

```ruby
response = Naver::Map.geocode(query: "불정로 6")
# => [#<Naver::ObjectifiedHash:70284981985920 {hash: {
  "address"=>"경기도 성남시 분당구 불정로  6 NAVER그린팩토리",
  "addrdetail"=>{"country"=>"대한민국", "sido"=>"경기도", "sigugun"=>"성남시 분당구", "dongmyun"=>"불정로", "rest"=>" 6 NAVER그린팩토리"},
  "isRoadAddress"=>true,
  "point"=>{"x"=>127.1052133, "y"=>37.3595316}}}
]

puts response[0].address
# => 경기도 성남시 분당구 불정로  6 NAVER그린팩토리

puts response[0].addrdetail.sido
# => 경기도
```

### 좌표 -> 주소 변환

```ruby
response = Naver::Map.reverse_geocode(lat: "127.1141382", lng: "37.3599968")
# => [#<Naver::ObjectifiedHash:70284981856220 {hash: {
  "address"=>"경기도 성남시 분당구 정자동 257-1",
  "addrdetail"=>{"country"=>"대한민국", "sido"=>"경기도", "sigugun"=>"성남시 분당구", "dongmyun"=>"정자동", "rest"=>"257-1"},
  "isAdmAddress"=>false,
  "isRoadAddress"=>false,
  "point"=>{"x"=>127.1164925, "y"=>37.3597611}}
  },
  ...
]

puts response[0].address
# => 경기도 성남시 분당구 불정로  6 NAVER그린팩토리

puts response[0].point.x
# => 127.1164925
```

## 단축URL

### url
```ruby
response = Naver::Shortenurl.url(url: "https://github.com/kimsuelim")
# => #<Naver::ObjectifiedHash:70284972276780 {hash: {
  "hash"=>"Fr4K6WFj",
  "url"=>"http://me2.do/Fr4K6WFj",
  "orgUrl"=>"https://github.com/kimsuelim"}
}

puts response.url
# => "http://me2.do/Fr4K6WFj"
```

## 파파고

### 한글인명 - 로마자 변환

```ruby
response = Naver::Papago.romanization(query: "김수림")
=> #<Naver::ObjectifiedHash:70284972145960 {hash: {
  "sFirstName"=>"김",
  "aItems"=>[
    {"name"=>"Kim Soorim", "score"=>"99"},
    {"name"=>"Kim Soolim", "score"=>"97"},
    {"name"=>"Kim Surim", "score"=>"78"},
    {"name"=>"Kim Sulim", "score"=>"76"}
  ]}
}

puts response.aItems[0].name
# => "Kim Soorim"
```

### 기계번역(Beta)

```ruby
response = Naver::Papago.translate(
  source: "ko",
  target: "en",
  text: "기술이 인간을 대체하는 것이 아니라 인간은 기술의 도움으로 더욱 창조적으로 될 것이라는 믿는다."
)

# => #<Naver::ObjectifiedHash:70362563050680 {hash: {
  "translatedText"=>"To replace the technology not believe that humans are more creatively with the help of technology."
  }
}

puts response.translatedText
# => "To replace the technology not believe that humans are more creatively with the help of technology."
```

## 네이버 공유하기

### url
```
Naver::Share.url(url: "https://github.com/kimsuelim", title: "The unofficial NAVER SDK for Ruby")
# => "http://share.naver.com/web/shareView.nhn?url=https%3A%2F%2Fgithub.com%2Fkimsuelim&title=The+unofficial+NAVER+SDK+for+Ruby"
```

## 클로바

### 음성합성(Beta)
```
response = Naver::Clova.tts(
  speaker: "mijin",
  speed: 0,
  text: "기술이 인간을 대체하는 것이 아니라 인간은 기술의 도움으로 더욱 창조적으로 될 것이라는 믿는다."
)

file = File.open("tts.mp3", "wb") { |f| f.write(response) }
# => 62532
```

## 검색

### 블로그
```ruby
search_results = Naver::Search.blog(query: "블로그")
# => <Naver::ObjectifiedHash:70284981057980 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 19:11:02 +0900", "total"=>26223046, "start"=>1, "display"=>10,
  "items"=>[
     {
       "title"=>"<b>블로그</b>마케팅교육 어떻게 시작해야 할까요?",
       "link"=>"http://blog.naver.com/roompen9030?Redirect=Log&amp;logNo=221030193550",
       "description"=>"업체를 운영하시거나 창업을 하신 모든 분들이 한번쯤은 <b>블로그</b>마케팅을 고민해보셨을 거예요. 하지만... 가장 좋은 방법은 큰 비용을 들이지 않고도 내가 스스로 <b>블로그</b>마케팅을 하는 거겠지만 어떻게 해야... ",
       "bloggername"=>"호러천국",
       "bloggerlink"=>"http://blog.naver.com/roompen9030",
       "postdate"=>"20170616"
      },
      ...
  ]
}

puts search_results.total
# => 26223041

puts search_results.items[0].bloggername
# => 호러천국
```

### 뉴스
```ruby
search_results = Naver::Search.news(query: "뉴스")
# => #<Naver::ObjectifiedHash:70284981108020 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 19:17:32 +0900", "total"=>31804178, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"'믿듣맘무' 마마무, 걸그룹 음원차트 평정… 멜론 누적 이용자수 94만명 돌파",
      "originallink"=>"http://enews24.tving.com/news/article.asp?nsID=1221358",
      "link"=>"http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=106&oid=404&aid=0000180862",
      "description"=>"녹아져 있는, 밉지 않은 귀여운 허세가 인상적인 큐티 허세송이다. 한편 마마무는 24일 MBC '쇼! 음악중심' 무대에 오른다. 사진 = RBW 제공 이지영 기자 [Copyright ⓒ Asia No.1 연예<b>뉴스</b> enews24.net 무단전재 및 재배포 금지]",
      "pubDate"=>"Sat, 24 Jun 2017 19:15:00 +0900"
    },
    ...
  ]
}

puts search_results.items[0].title
# => '믿듣맘무' 마마무, 걸그룹 음원차트 평정… 멜론 누적 이용자수 94만명 돌파
```

### 책
```ruby
search_results = Naver::Search.book(query: "책")
# => #<Naver::ObjectifiedHash:70284982544600 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:08:46 +0900", "total"=>555896, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"너의 이름은",
      "link"=>"http://book.naver.com/bookdb/book_detail.php?bid=11463103",
      "image"=>"http://bookthumb.phinf.naver.net/cover/114/631/11463103.jpg?type=m1&udate=20170512",
      "author"=>"신카이 마코토",
      "price"=>"11000",
      "discount"=>"9900",
      "publisher"=>"대원씨아이",
      "pubdate"=>"20170117",
      "isbn"=>"1133440053 9791133440054",
      "description"=>"아직 만난 적 없는 너를, 지금부터 나는 찾으러 간다!애 니메이션 차세대 거장으로 거듭난 신카이 마코토 감독이 직접 집필한 극장 애니메이션 《너의 이름은。》의 원작 소설 『너의 이름은.』. 《언어의 정원》, 《초속 5센티미터》 등 자신의 작품을 섬세한 필체를 살려 소설화 해온 신카이 마코토 감독.... "
    },
    ...
  ]
}

puts search_results.items[0].title
# => "너의 이름은"
```

### 성인 검색어 판별
```ruby
response = Naver::Search.adult(query: "성인")
puts response.adult
# => true

response = Naver::Search.adult(query: "청소년")
puts response.adult
# => false
```

### 백과 사전
```ruby
search_results = Naver::Search.encyc(query: "백과 사전")
# => #<Naver::ObjectifiedHash:70284982397080 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:12:58 +0900", "total"=>4332, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"<b>백과사전</b>",
      "link"=>"http://terms.naver.com/entry.nhn?docId=556891&cid=46669&categoryId=46669",
      "description"=>" 과학·자연 및 인간의 활동에 따른 일체의 지식을 압축 정리해서 각 사항을 가나다순(알파벳순), 분류순 또는 기타 일정한 순서로 배열하여 엮은 책. [내용] 동양, 그 가운데에서도 특히 중국에서는... ",
      "thumbnail"=>"http://openapi-dbscthumb.phinf.naver.net/2644_000_9/20150328034129739_UX34MP75L.jpg/4b8709b1-60ab-47.jpg?type=m160_160"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "<b>백과사전</b>"
```

### 영화
```ruby
search_results = Naver::Search.movie(query: "킬빌")
# => #<Naver::ObjectifiedHash:70284982296880 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:15:41 +0900", "total"=>3, "start"=>1, "display"=>3,
  "items"=>[
    {
      "title"=>"<b>킬 빌</b> - 2부",
      "link"=>"http://movie.naver.com/movie/bi/mi/basic.nhn?code=37493",
      "image"=>"http://imgmovie.naver.com/mdi/mit110/0374/C7493-00.jpg",
      "subtitle"=>"Kill Bill: Vol. 2",
      "pubDate"=>"2004",
      "director"=>"쿠엔틴 타란티노|",
      "actor"=>"우마 서먼|데이빗 캐러딘|",
      "userRating"=>"7.48"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "<b>킬 빌</b> - 2부"
```

### 카페글
```ruby
search_results = Naver::Search.cafearticle(query: "카페글")
# => #<Naver::ObjectifiedHash:70284982183260 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:17:56 +0900", "total"=>216425, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"예전 <b>카페글</b> 복습하기",
      "link"=>"http://cafe.naver.com/cosmicordering/26633",
      "description"=>"많아서 공유글도 나쁘지는 않지만 요즘 글들은 어째 예전 거보다 질적인 측면에서 많이 떨어진다는 생각이... 이것만큼은 꼭 읽으면 도움된다 하는 글들 위주로 쪽지, 혹은 <b>카페글</b>로 올려드릴게요. :) 그럼 한 주도 화잇팅~~~ ",
      "cafename"=>"우루사 _ 우주 택배를 받고 소원을 이...",
      "cafeurl"=>"http://cafe.ㅜver.com/cosmicordering"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "예전 <b>카페글</b> 복습하기"
```

### 지식 iN
```ruby
search_results = Naver::Search.kin(query: "지식인")
# => #<Naver::ObjectifiedHash:70284982086840 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:20:19 +0900", "total"=>6931274, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"<b>지식인</b> 디렉토리 변경",
      "link"=>"http://kin.naver.com/qna/detail.nhn?d1id=1&dirId=1060101&docId=278622531&qb기KeA7Iud7J24&enc=utf8&section=kin.qna&rank=1&search_sort=0&spq=0",
      "description"=>"<b>지식인</b> 디렉토리 변경 어떻게 하나요? 첫번째 화면에서 디렉토리 변경 요청을... 아오 <b>지식인</b> 서비스 진짜 불편해졌네 디렉토리 이동 권한이 없는... 분야별<b>지식인</b> 유저에게는 디렉토리 이동 방능이 있어 원하신다면 확인 후 제가... "
    },
    ...
  ]
}

puts search_results.items[0].title
# => "<b>지식인</b> 디렉토리 변경"
```

### 지역
```ruby
search_results = Naver::Search.local(query: "제주도")
# => #<Naver::ObjectifiedHash:70284981059020 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:51:22 +0900", "total"=>75791, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"제주특별자치도청",
      "link"=>"http://www.jeju.go.kr/",
      "category"=>"공공,사회기관>도청",
      "description"=>"제주 뉴스, 생활민원, 여권발급, 문화, <b>제주도</b> 관광, 산업경제, 복지, 여성 정보 수록.",
      "telephone"=>"",
      "address"=>"제주특별자치도 제주시 연동 312-1 ",
      "roadAddress"=>"제주특별자치도 제주시 문연로 6 ",
      "mapx"=>"260641",
      "mapy"=>"100237"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "제주특별자치도청"
```

### 오타변환
```ruby
response = Naver::Search.errata(query: "오타")
puts response.errata
# => nil

response = Naver::Search.errata(query: "dhxk")
puts response.errata
# => "오타"
```

### 웹문서
```ruby
search_results = Naver::Search.webkr(query: "웹문서")
# => #<Naver::ObjectifiedHash:70284981547180 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:53:29 +0900", "total"=>1904994, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"카카오톡 <b>웹문서</b> 수집 인정 &quot;다음 검색 연동 중단&quot; - 오마이뉴스",
      "link"=>"http://www.ohmynews.com/NWS_Web/View/at_pg.aspx?CNTN_CD=A0002213337",
      "description"=>"[보도 후] 카카오 &quot;1월부터 검색 노출, &lt;오마이뉴스&gt; 보도 우려 반영해 중지&quot;"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "카카오톡 <b>웹문서</b> 수집 인정 &quot;다음 검색 연동 중단&quot; - 오마이뉴스"
```

### 이미지
```ruby
search_results = Naver::Search.image(query: "이미지")
# => #<Naver::ObjectifiedHash:70284981346800 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:54:58 +0900", "total"=>1627087, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"볼매뿌뿌's StyleShare",
      "link"=>"https://usercontents-a.styleshare.kr/images/9764328/original",
      "thumbnail"=>"http://tv02.search.naver.net/ugc?q=https://usercontents-a.styleshare.kr/images/9764328/original",
      "sizeheight"=>"285",
      "sizewidth"=>"420"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "볼매뿌뿌's StyleShare"
```

### 쇼핑
```ruby
search_results = Naver::Search.shop(query: "쇼핑")
# => #<Naver::ObjectifiedHash:70284981152140 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:56:19 +0900", "total"=>8895965, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"팩앤롤 접이식 휴대용 핸드 <b>쇼핑</b>카트",
      "link"=>"http://shopping.naver.com/gate.nhn?id=11449581836",
      "image"=>"http://shopping.phinf.naver.net/main_1144958/11449581836.2.jpg",
      "lprice"=>"10400",
      "hprice"=>"0",
      "mallName"=>"베이직기프트",
      "productId"=>"11449581836",
      "productType"=>"2"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "팩앤롤 접이식 휴대용 핸드 <b>쇼핑</b>카트"
```

### 전문자료
```ruby
search_results = Naver::Search.doc(query: "전문자료")
# => #<Naver::ObjectifiedHash:70284980468480 {hash: {
  "lastBuildDate"=>"Sat, 24 Jun 2017 20:57:34 +0900", "total"=>41554, "start"=>1, "display"=>10,
  "items"=>[
    {
      "title"=>"이미지 검색 기능을 가진 문서간 <b>전문자료</b>의 유사도 검색 시스템",
      "link"=>"http://academic.naver.com/view.nhn?doc_id=189708176",
      "description"=>"The full-text document similarity retrieval system including image retrieval  표제지\n목차\n국문초록 9\nABSTRACT 11\n제1장 서"
    },
    ...
  ]
}

puts search_results.items[0].title
# => "이미지 검색 기능을 가진 문서간 <b>전문자료</b>의 유사도 검색 시스템"
```

## Authentication

네이버 아이디로 로그인 API는 네이버 로그인 인증 요청 API, 접근 토큰 발급/갱신/삭제 요청API로 구성되어 있습니다.

### OAuth access tokens

네이버 아이디로 로그인 API는 네이버 로그인 인증 요청 API, 접근 토큰 발급/갱신/삭제 요청API로 구성되어 있습니다.
네이버 로그인 인증 요청 API는 여러분의 웹 또는 앱에 네이버 로그인 화면을 띄우는 API입니다.

```ruby
oauth = Naver::Oauth.new(redirect_uri: "http://127.0.0.1/oauth/callback")
auth_url = oauth.authorization_url
puts auth_url
# => https://nid.naver.com/oauth2.0/authorize?client_id=GssyV0tCqRYPMRkDKsgG&redirect_uri=http%3A%2F%2F127.0.0.1%2Foauth%2Fcallback&response_type=code&scope=public
```

Upon authorization, Naver will return to you an authentication code via your OAuth
callback handler. With that you can generate an access token:

이용자가 네이버 회원 인증에 성공하면 API로부터 받은 code 값을 이용해서 접근 토큰 발급 요청 API를 호출합니다.

```ruby
oauth = Naver::Oauth.new(redirect_uri: "http://127.0.0.1/oauth/callback")
oauth.authorize!("bdIdbpkuTwzk06Y3")
oauth.extract_token
# => {
  "token_type"=>"bearer",
  "access_token"=>"AAAAOrmgLwPV1AcF5UBThDNkruDPEMsAJ7gyyRneAgpwAPgdm2MQj1EYOiQ9femIhs9fGW2I2PNUgrc1ZFJuy5lFo6M=",
  "refresh_token"=>"fXKPyKGM2zfAxfgrDQKBA60CKsM8h9BlfqisQvtTiiWnwF5vYlAghIBSu6WvNrSmDLCCmKrfVFipEbJurOxFLoW6NdohlIqCp4mSdviiHZxLTYR0aPwnbxWmkByk70ZisuX3A",
  "expires_at"=>1498212486
}

response = Naver::Profile.me
# => {
  "nickname"=>"갈루트",
  "enc_id"=>"86744e27d4bfdb3cddb478293d295cf783ce9ed41f0ad7687bac26e97a1ed1b4",
  "profile_image"=>"https://phinf.pstatic.net/contact/52/2016/2/11/kimsuerim_1455194287821.jpg",
  "age"=>"30-39",
  "gender"=>"M",
  "id"=>"48189785",
  "name"=>"JINxx",
  "email"=>"kimsuerim@naver.com",
  "birthday"=>"01-08"
}

puts response.nickname
# => "갈루트"
```

접근 토큰 발급 요청 API를 통해 받은 접근 토큰(access token) 값은 다음과 같이 회원 프로필 조회를 비롯하여 여러가지 로그인 오픈 API를 호출하는데 사용할 수 있습니다.

## Advanced usage

Since naver-sdk employs [Faraday][faraday] under the hood, some behavior can be
extended via middleware.

### Debugging

Often, it helps to know what naver-sdk is doing under the hood. You can add a
logger to the middleware that enables you to peek into the underlying HTTP
traffic:

```ruby
Naver.configure do |config|
  config.debug = true
end
Naver::Search.blog(query: "블로그")
```
```
I, [2017-06-24T11:59:40.920421 #54253]  INFO -- : get https://openapi.naver.com/v1/search/blog?query=%EC%A7%91%EB%B0%A5
D, [2017-06-24T11:59:40.920569 #54253] DEBUG -- request: User-Agent: "NAVER SDK Ruby Gem 0.1.0"
X-Naver-Client-Id: "GssyV0tCqRYPMRkDKsgG"
X-Naver-Client-Secret: "ScVEl_cDJA"
I, [2017-06-24T11:59:41.182547 #54253]  INFO -- Status: 200
D, [2017-06-24T11:59:41.182674 #54253] DEBUG -- response: server: "nginx"
date: "Sat, 24 Jun 2017 02:59:39 GMT"
content-type: "application/json;charset=UTF-8"
transfer-encoding: "chunked"
connection: "close"
vary: "Accept-Encoding"
x-powered-by: "Naver"
cache-control: "no-cache, no-store, must-revalidate"
pragma: "no-cache"
...
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kimsuelim/naver-sdk-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Naver::Sdk project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kimsuelim/naver-sdk-ruby/blob/master/CODE_OF_CONDUCT.md).

[Faraday]: https://github.com/lostisland/faraday
