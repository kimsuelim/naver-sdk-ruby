# Change Log
All notable changes to this project will be documented in this file.

## [unreleased]

## [0.5.0] - 2017-07-09
- improve configration
- core_ext/hash/keys

## [0.4.0] - 2017-06-26
- [breaking] JSON 출력 결과를 CamelCase 에서 underscore 변경
- [breaking] Naver::Papago.romanization 리턴값의 key 변경. s_first_name -> first_name,
  a_items -> items

## [0.3.0] - 2017-06-26
- [new] 얼굴인식(Beta)
- [breaking] `Naver::Clova::tts` renamed to `Naver::Voice.tts`.
- [breaking] `Naver::Shortenurl::url` renamed to `Naver::Shorturl::shorten`.

## [0.2.0] - 2017-06-25
- [new] 음성합성(Beta)
- [new] 네이버 공유하기
- [breaking] Naver::Search.adult 리턴값을 "1" -> true, "0" -> false로 변경
- [breaking] Naver::Search.errata에서 오타가 없을 경우 리턴값을 "" -> nil로 변경

## [0.1.0] - 2017-06-24

- first release

[0.1.0]: https://github.com/kimsuelim/naver-sdk-ruby/releases/tag/v0.1.0
[0.2.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.1.0...v0.2.0
[0.3.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.2.0...v0.3.0
[0.4.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.3.0...v0.4.0
[0.5.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.4.0...v0.5.0
[unreleased]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.5.0...HEAD
