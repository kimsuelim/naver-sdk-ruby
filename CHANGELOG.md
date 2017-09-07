# Changelog
All notable changes to this project will be documented in this file.

## [Unreleased]

## [0.6.1] - 2017-09-07
### Fixed
- Fix Rails compatibility issue

## [0.6.0] - 2017-07-09
### Changed
-  rename Configration -> Configuration, configration -> configuration

## [0.5.0] - 2017-07-09
### Changed
- improve configuration
- core_ext/hash/keys

## [0.4.0] - 2017-06-26
### Changed
- [breaking] JSON 출력 결과를 CamelCase 에서 underscore 변경
- [breaking] Naver::Papago.romanization 리턴값의 key 변경. s_first_name -> first_name,
  a_items -> items

## [0.3.0] - 2017-06-26
### Added
- 얼굴인식(Beta)

### Changed
- [breaking] `Naver::Clova::tts` renamed to `Naver::Voice.tts`.
- [breaking] `Naver::Shortenurl::url` renamed to `Naver::Shorturl::shorten`.

## [0.2.0] - 2017-06-25
### Added
- 음성합성(Beta)
- 네이버 공유하기

### Changed
- [breaking] Naver::Search.adult 리턴값을 "1" -> true, "0" -> false로 변경
- [breaking] Naver::Search.errata에서 오타가 없을 경우 리턴값을 "" -> nil로 변경

## [0.1.0] - 2017-06-24
### Added
- 한글인명 로마자 변환
- 기계번역(Beta)
- 주소 -> 좌표 변환
- 좌표 -> 주소 변환
- 단축 URL
- 네이버 공유하기
- 검색

[Unreleased]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.6.1...HEAD
[0.6.1]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/kimsuelim/naver-sdk-ruby/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/kimsuelim/naver-sdk-ruby/releases/tag/v0.1.0
